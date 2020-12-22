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
    @State var didFinishedLoading = false
    
    var body: some View {
        return ZStack{
            ArticlePage(articleUrlPath: articleUrlPath,
                        didFinishLoading: self.$didFinishedLoading)
            
        if !didFinishedLoading{
            LoadingView()
           }
          }
        .navigationBarTitle( "\(URL(string: articleUrlPath)!.host!)").font(.title)
 }
}


struct ArticleDetail_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetail(articleUrlPath: "https://www.vg.no")
    }
}
