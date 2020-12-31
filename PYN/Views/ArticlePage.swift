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
   
    let articleUrlPath: String
    @Binding var didFinishLoading: Bool
    @Binding var loadingDidFail: Bool
    
    
    func makeUIView(context: Context) -> WKWebView{
        
        
        guard let url = URL(string: articleUrlPath) else {fatalError("Invalid URL")}
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
            self.parent.didFinishLoading = true
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!,
                     withError error: Error) {
            self.parent.didFinishLoading = true
            self.parent.loadingDidFail = true
        }
    }
}
