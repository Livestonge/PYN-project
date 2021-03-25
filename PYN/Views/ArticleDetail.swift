//
//  ArticleDetail.swift
//  FNews
//
//  Created by awaleh moussa hassan on 22/07/2020.
//  Copyright © 2020 awaleh moussa hassan. All rights reserved.
//

import SwiftUI

struct ArticleDetail: View {
    
    let articleUrlPath: String
    @State private var didFinishedLoading = false
    @State private var pageLoadingFailed = false
    
    var body: some View {
        return ZStack{
            if !pageLoadingFailed {
                ArticlePage(articleUrlPath: articleUrlPath,
                            didFinishLoading: self.$didFinishedLoading,
                            loadingDidFail: $pageLoadingFailed)
            }else {
                NetworkingStatus()
            }
            if !didFinishedLoading{
                LoadingView(size: CGSize(width: 110, height: 110))
               }
              }
            .navigationBarTitle( "\(URL(string: articleUrlPath)?.host ?? "")").font(.title)
 }
}


struct ArticleDetail_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetail(articleUrlPath: "https://www.vg.no")
            .colorScheme(.dark)
    }
}
