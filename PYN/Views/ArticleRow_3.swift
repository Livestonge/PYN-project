//
//  ArticleRow_3.swift
//  testProject
//
//  Created by awaleh moussa hassan on 06/11/2020.
//

import SwiftUI

struct ArticleRow_3: View {
    var article: CompleteArticle
    
    var body: some View {
        
        return HStack(alignment: .center){
            Image(uiImage: (article.imageData != nil ? UIImage(data: article.imageData!)! : UIImage(systemName: "globe")!))
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(10)
            VStack(alignment: .leading){
                Text(article.rawArticle.title ?? "")
                    .font(.headline)
                    .lineLimit(2)
                    .allowsTightening(true)
                HStack {
                    Text(article.rawArticle.source.name ?? "")
                        .font(.subheadline)
                        .fontWeight(.thin)
                        .padding(.top)
                    Spacer()
                    Text(article.rawArticle.formattedDate)
                        .font(.subheadline)
                        .fontWeight(.thin)
                        .padding(.top)
                }
            }
        }
    }
}
