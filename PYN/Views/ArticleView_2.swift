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
                NavigationLink(destination: ArticleDetail(article: article.rawArticle)){
                    ArticleRow_3(article: article)
                }
            }
            .frame(height: 100.0)
    }
}
