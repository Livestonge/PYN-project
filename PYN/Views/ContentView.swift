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
                    if self.searchResultProvider.isLoading{
                        LoadingView(size: CGSize(width: 50,
                                                 height: 50))
                            .offset(CGSize(width: 0,
                                           height: -geometry.size.height/2))
                    }
                    if self.searchResultProvider.showLanguagedView{
                        LanguagesView(index: self.$searchResultProvider.selectedIndex,
                                      action: self.searchResultProvider.performNetworkRequest)
                            .frame(width: geometry.size.width * 0.8,
                                   alignment: .center)
                            .zIndex(10)
                            .transition(.move(edge: .bottom))
                    }
                }
            }
            .alert(isPresented: self.$searchResultProvider.errorDidOccured){
                Alert(title: Text("OOPS"),
                      message: Text("\(self.searchResultProvider.seachError!.description)"),
                      dismissButton: .default(Text("Got it!!!")))
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SearchResultProvider())
    }
}
