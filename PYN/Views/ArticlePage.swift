//
//  ArticlePage.swift
//  FNews
//
//  Created by awaleh moussa hassan on 02/09/2020.
//  Copyright © 2020 awaleh moussa hassan. All rights reserved.
//

import Foundation
import SwiftUI
import WebKit

struct ArticlePage: UIViewRepresentable {
   
    var article: RawArticle
    @Binding var didFinishLoading: Bool
    
    func makeUIView(context: Context) -> WKWebView{
        
        
        guard let url = URL(string: article.url!) else {fatalError("Invalid URL")}
        let request = URLRequest(url: url)
        let webView = WKWebView()
        webView.load(request)
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        //Doing Nothing....
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate{
        
        var parent: ArticlePage
        
        init(_ parent: ArticlePage){
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
            parent.didFinishLoading = false
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
            parent.didFinishLoading = true
        }
    }
}
