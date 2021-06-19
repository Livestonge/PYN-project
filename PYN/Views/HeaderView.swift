//
//  HeaderView.swift
//  testProject
//
//  Created by awaleh moussa hassan on 10/11/2020.
//

import SwiftUI

struct SectionView: View{
    
    @EnvironmentObject var searchResultProvider: SearchResultProvider
    var query: Query
    var body: some View{
        Section(header:
                    HeaderView(query: query)
        ){
            ArticleView_2(articles: Array(query.articles))
        }
    }
}

struct HeaderView: View {
    
    var query: Query
    @EnvironmentObject var searchResultProvider: SearchResultProvider
    var body: some View {
        HStack{
            Text(query.title)
                .font(.headline)
                .foregroundColor(.primary)
            Spacer()
            Button(action: self.removeQuery){
                Image(systemName: "minus.circle")
                    .foregroundColor(.red)
                    .font(.title2)
            }
        }
        .padding()
        
    }
    
    private func removeQuery(){
        self.searchResultProvider.delete(self.query)
    }
}


struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        let query = Query(title: "Oslo")
        SectionView(query: query)
            //.previewLayout(.sizeThatFits)
    }
}
