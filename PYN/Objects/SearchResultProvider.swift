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
    
    
    @Published var showLanguagedView = false
    @Published var results = Set<Query>()
    @Published var selectedIndex = 0
    var subscriptions = Set<AnyCancellable>()
    
    var currentSearchTitle = ""
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
        
    }
    
    private func subscribeToManagersSearchResult(){
        
        self.dataManager.$searchResult
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] queries in
                guard let self = self else {return}
                self.results = queries
            })
            .store(in: &subscriptions)
    }
    
    func performNetworkRequest(){
        let query = self.currentSearchTitle
        self.dataManager.fetchData(for: query, selectedLanguageIndex: selectedIndex)
        showLanguagedView = false
    }
    
    func loadFromDisc(){
        self.dataManager.loadDataFromDisk()
    }
    
    func saveToDisc(){
        self.dataManager.saveDataToDisk()
    }
}

extension SearchResultProvider: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        if let title = searchController.searchBar.text, !title.isEmpty{
            self.currentSearchTitle = title
            showLanguagedView = true
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
       
//        self.showSearchedItems = false
//        self.showLanguages = false

    }
  
}
