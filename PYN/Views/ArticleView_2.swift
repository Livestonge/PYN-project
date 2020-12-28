//
//  articleView_2.swift
//  testProject
//
//  Created by awaleh moussa hassan on 06/11/2020.
//

import SwiftUI

struct ArticleView_2: View {
    var articles: [CompleteArticle]
    
    var body: some View {
            ForEach(articles){ article in
                NavigationLink(destination: ArticleDetail(articleUrlPath: article.rawArticle.url!)){
                    ArticleRow_3(imageData: article.imageData,
                                 title: article.rawArticle.title ?? "",
                                 source: article.rawArticle.source.name ?? "",
                                 date: article.formattedDate)
                }
            }
            .frame(height: 100.0)
    }
}
