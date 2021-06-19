//
//  SearchResultProvider.swift
//  testProject
//
//  Created by awaleh moussa hassan on 06/11/2020.
//

import Foundation
import SwiftUI
import Combine

final class SearchResultProvider: NSObject, ObservableObject{
    
    @Published var results = Set<Query>()
    @Published var selectedIndex = 0
    @Published var errorDidOccured = false
    
    @Published var state: State = .isPending
    var searchError: NetworkError?
    
    var subscriptions = Set<AnyCancellable>()
    
    private var currentSearchTitle = ""
    let searchController: UISearchController!
    lazy var dataManager = DataManager()
    
    
    override init(){
        
        self.searchController = UISearchController(searchResultsController: nil)
        super.init()
        // Makes sure that we kan scroll up and down when the searchBar is the first responder.
        self.searchController.obscuresBackgroundDuringPresentation = false
        //self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
        
        self.subscribeToManagersSearchResult()
        
        self.dataManager.$didReceiveError.sink(receiveValue: {error in
            if error != nil{
                self.errorDidOccured = false
                self.state = .isPending
                self.searchError = error
            }
        }).store(in: &subscriptions)
        
    }
    
    private func subscribeToManagersSearchResult(){
        
        self.dataManager.$searchResult
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] queries in
                guard let self = self else {return}
                self.results = queries
                self.state = .isPending
            })
            .store(in: &subscriptions)
    }
    
    func performNetworkRequest(){
        let query = self.currentSearchTitle
        self.searchError = nil
        self.dataManager.fetchData(for: query, selectedLanguageIndex: selectedIndex)
        updateLanguageViewTo(.isLoading)
    }
    
    func loadFromDisc(){
        self.dataManager.loadDataFromDisk()
    }
    
    func saveToDisc(){
        self.dataManager.saveDataToDisk()
    }
    
    func delete(_ query: Query){
        self.dataManager.remove(query)
    }
    
    private func updateLanguageViewTo(_ state: State){
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            withAnimation(Animation.easeInOut(duration: 2)){
                self.state = state
        
            }

        }
    }
}

extension SearchResultProvider: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        if let title = searchController.searchBar.text, !title.isEmpty{
            self.currentSearchTitle = title
            updateLanguageViewTo(.isShowingLanguage)
            
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
       
//        self.showSearchedItems = false
        updateLanguageViewTo(.isPending)

    }
  
}
