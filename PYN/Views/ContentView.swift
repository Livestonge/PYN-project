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
                            SectionView(query: query)
                             .padding([.top, .bottom], 10)
                      }
                    }
                    auxilaryView(geometry: geometry)
                }
            }
            .alert(isPresented: self.$searchResultProvider.errorDidOccured){
                Alert(title: Text("OOPS"),
                      message: Text("\(self.searchResultProvider.searchError!.description)"),
                      dismissButton: .default(Text("Got it!!!")))
            }
    }
}

extension ContentView{
    
    func auxilaryView(geometry: GeometryProxy) -> some View{
        
        return Group{
            
           switch self.searchResultProvider.state{
           case .isPending:
               EmptyView()
           case .isShowingLanguage:
               LanguagesView(index: self.$searchResultProvider.selectedIndex,
                                            action:  self.searchResultProvider.performNetworkRequest)
                               .frame(width: geometry.size.width * 0.8,
                                       alignment: .center)
                               .zIndex(10)
                               .transition(.move(edge: .bottom))
           case .isLoading:
               LoadingView(size: CGSize(width: 80,
                                        height: 80)
                                       )
                                       .offset(CGSize(width: 0,
                                               height: -geometry.size.height/2))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SearchResultProvider())
    }
}
