//
//  ArticleDetail.swift
//  FNews
//
//  Created by awaleh moussa hassan on 22/07/2020.
//  Copyright © 2020 awaleh moussa hassan. All rights reserved.
//

import SwiftUI
import Combine

struct ArticleDetail: View {
    
    var article: RawArticle
    @State var didFinishedLoading = false
    
    var body: some View {
        ZStack {
            ArticlePage(article: article,
                        didFinishLoading: self.$didFinishedLoading)
        }
        .navigationBarTitle(article.source.name ?? "").font(.title)
    }
}
