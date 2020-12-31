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
    var metadataSet = Set<Metadata>()
    var subscriptions = Set<AnyCancellable>()
    
    lazy private var networking = Networking()
    lazy private var cache = Cache<UUID, CompleteArticle>()
    
    init(){
        subscribingToMemoryCacheActivities()
    }
    
    private func subscribingToMemoryCacheActivities(){

        _ = self.cache.keyTracker.$removedKey
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] key in
                guard let self = self, key != nil else {return}
                guard let entry = self.cache.retrieveEntry(for: key!) else {return}
                _ = self.searchResult.updatesResults(for: nil,
                                                     and: entry.value,
                                                     removeArticle: true)
            })
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
            guard article.metadata.fetchDate.isOldData
            else {continue}
            // fetching the metadata from the article before removing from the cache.
            self.metadataSet.insert(article.metadata)
            self.cache.remove(key: entry.key)
        }
    }
    
    private func fetchNewData(){
        
        if !self.metadataSet.isEmpty{
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
            })
            .store(in: &subscriptions)
    }
    
    private func dowloadImages(forArticlesWith queryTitle: String){

        self.searchResult.publisher
                              .flatMap(\.articles.publisher)
                              .filter({ $0.metadata.title == queryTitle})
                              .subscribe(on: DispatchQueue.global())
                              .map({(article: CompleteArticle) -> CompleteArticle in
                                var newArticle = article
                                newArticle.downloadImage()
                                return newArticle
                               })
                               .receive(on: DispatchQueue.main)
                               .sink(receiveValue: {[weak self] completeArticle in
                                guard let self = self else {return}
                                self.updateSearchResultAndCache(for: queryTitle,
                                                                with: completeArticle)
                               })
                               .store(in: &subscriptions)
    }
    
    
    
    private func updateSearchResultAndCache(for queryTitle: String,
                                            with completeArticle: CompleteArticle){
        
        guard let article = self.searchResult.updatesResults(for: queryTitle, and: completeArticle)
        else {return}
        self.cache.insert(value: article, for: article.id)
    }
}
