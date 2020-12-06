//
//  RawModel.swift
//  testProject
//
//  Created by awaleh moussa hassan on 09/11/2020.
//

import Foundation

struct RawArticle: Codable, Hashable{
    
    static func == (lhs: RawArticle, rhs: RawArticle) -> Bool {
        return lhs.description == rhs.description
    }
    
    
    struct RawSource: Codable, Hashable{
          let id: String?
          let name: String?
    }
    
    let author: String?
    let source: RawSource
    let title: String?
    let url: String?
    let description: String?
    let content: String?
    let publishedAt: String?
    let urlToImage: String?
    
    
    
}

struct SearchResult: Codable{
    
    let status: String?
    let articles: [RawArticle]
}
