//
//  RawModel.swift
//  testProject
//
//  Created by awaleh moussa hassan on 09/11/2020.
//

import Foundation

public struct Article {
    
    enum ArticleKeys: CodingKey{
        case source, title, url, publishedAt, urlToImage
    }
    enum SourceKeys: CodingKey{
        case id, name
    }
    
    let media: String
    let title: String
    let url: String
    let publishedAt: String
    let urlToImage: String
}

extension Article: Hashable{
    
    public static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.title == rhs.title
    }
}



struct SearchResult: Codable{
    
    let status: String?
    let articles: [Article]
}



