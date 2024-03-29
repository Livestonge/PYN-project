//
//  DataManager.swift
//  testProject
//
//  Created by awaleh moussa hassan on 21/11/2020.
//

import Foundation
import SwiftUI
import Combine

final class DataManager: ObservableObject{
    
    @Published var searchResult = Set<Query>()
    @Published var didReceiveError: NetworkError?
    @Published var isFetchingData = false
    var metadataSet = Set<Metadata>()
    var subscriptions = Set<AnyCancellable>()
    
    lazy private var networking = Networking()
    lazy private var cache = Cache<UUID, CompleteArticle>()
    
    init(){
        subscribingToMemoryCacheActivities()
    }
    
    private func subscribingToMemoryCacheActivities(){

        self.cache.keyTracker.$removedValue
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                guard let self = self, value != nil else {return}
                _ = self.searchResult.updatesResults(with: value!,removeArticle: true)
            })
            .store(in: &subscriptions)
    }
    
    
    func loadDataFromDisk(){
        
        self.cache.loadFromDisk()
        getRidOfOldData()
        filterAndOrganizeData()
        // Updating every hour and
        // only when the app is moving to the foreground.
        fetchNewData()
    }
    
    func getRidOfOldData(){
        
        let entries = self.cache.retrieveAll()
        for entry in entries{
            let article = entry.value
            guard article.metadata.fetchedDate.isOldData
            else {continue}
            // fetching the metadata from the article before removing from the cache.
            self.metadataSet.insert(article.metadata)
            self.cache.remove(key: entry.key)
        }
    }
    
    func remove(_ query: Query){
        for article in query.articles{
            self.cache.remove(key: article.id)
        }
    }
    
    private func fetchNewData(){
        
        if !self.metadataSet.isEmpty{
            self.isFetchingData = true
            for metadata in metadataSet{
                let index = Language.firstIndexOf(metadata.language)
                self.fetchData(for: metadata.title, selectedLanguageIndex: index)
            }
            // Empty the list after new data has been fetched.
            self.metadataSet.removeAll()
        }
    }
    
    private func filterAndOrganizeData(){
        
        let entries = self.cache.retrieveAll()
        var resultSet = Set<[CompleteArticle]>()
        
        entries.forEach{ entry in
            let filtered = entries.filter{ $0.value.metadata.title == entry.value.metadata.title}
            resultSet.insert(filtered.map(\.value))
        }
        
        for articles in Array(resultSet){
            guard let article = articles.first else {return}
            let query = Query(title: article.metadata.title, articles: articles)
            self.searchResult.insert(query)
        }
    }

    func saveDataToDisk(){
        self.cache.saveToDisc()
        self.searchResult.removeAll()
        self.metadataSet.removeAll()
    }
    
    func fetchData(for queryTitle: String, selectedLanguageIndex: Int){
        
        let language = Language.allCases[selectedLanguageIndex]
        self.didReceiveError = nil
        
        self.networking.fetchData(query: queryTitle, language: language)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {completion in
                switch completion{
                case .failure(let error):
                    self.didReceiveError = error
                    self.isFetchingData = false
                default:
                    break
                }
            }, receiveValue: { [weak self] completeArticles in
                guard let self = self else {return}
                let articles = Array(completeArticles.prefix(4))
                var queryObj = Query(title: queryTitle)
                queryObj.articles = articles
                self.searchResult.insert(queryObj)
                self.dowloadImages(forArticlesWith: queryTitle)
                self.isFetchingData = false
            })
            .store(in: &subscriptions)
    }
    
    private func dowloadImages(forArticlesWith queryTitle: String){

        self.searchResult.publisher
                              .flatMap(\.articles.publisher)
                              .filter({ $0.metadata.title == queryTitle})
                              .subscribe(on: DispatchQueue.global())
                              .flatMap(downloadImageFor)
                              .receive(on: DispatchQueue.main)
                              .sink(receiveValue: {[weak self] completeArticle in
                              guard let self = self else {return}
                              self.updateSearchResultAndCache(completeArticle)
                              })
                              .store(in: &subscriptions)
    }
    
    private func downloadImageFor(article: CompleteArticle) -> AnyPublisher<CompleteArticle, Never>{
        
        let path = article.rawArticle.urlToImage
        guard !path.isEmpty, let url = URL(string: path)
        else {return Just(article).eraseToAnyPublisher()}
        
        return URLSession.shared.dataTaskPublisher(for: url)
                 .map(\.data)
                 .map{(data: Data) -> UIImage? in
                     return UIImage(data: data)}
                 .map{(image: UIImage?) -> CompleteArticle in
                     var newArticle = article
                     newArticle.imageData = image?.pngData() ?? article.imageData
                     return newArticle
                 }
                 .replaceError(with: article)
                 .eraseToAnyPublisher()
            
    }
    
    
    
    private func updateSearchResultAndCache(_ completeArticle: CompleteArticle){
        
        guard let article = self.searchResult.updatesResults(with: completeArticle)
        else {return}
        self.cache.insert(value: article, for: article.id)
    }
}
