//
//  ContentView.swift
//  testProject
//
//  Created by awaleh moussa hassan on 06/11/2020.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var searchResultProvider: SearchResultProvider
    @State var query: String = ""
    
    var body: some View {
        return NavigationView{
            GeometryReader{geometry in
                ZStack(alignment: .bottom){
                    List{
                        ForEach(Array(self.searchResultProvider.results), id: \.self){ query in
                            Section(header: HeaderView(title: query.title)){
                                    ArticleView_2(articles: Array(query.articles))
                                }
                            }
                        .padding([.top, .bottom], 10)
                    }
                    if self.searchResultProvider.showLanguagedView{
                        LanguagesView(index: self.$searchResultProvider.selectedIndex,
                                      action: self.searchResultProvider.performNetworkRequest)
                            .frame(width: geometry.size.width * 0.8,
                                   alignment: .center)
                    }
                }
            }
            .navigationTitle(self.searchResultProvider.results.isEmpty
                                ? "Make a search" : "Search result").font(.subheadline)
            .overlay(
                ViewControllerResolver{ viewController in
                viewController.navigationItem.searchController = self.searchResultProvider.searchController
                }
                .frame(width: 0, height: 0)
            )
            }
        
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
