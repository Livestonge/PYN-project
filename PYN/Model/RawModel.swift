//
//  RawModel.swift
//  testProject
//
//  Created by awaleh moussa hassan on 09/11/2020.
//

import Foundation

struct RawArticle: Codable, Hashable{
    
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.title == rhs.title
    }
    
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

extension Article: Codable{
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: Self.ArticleKeys)
        let sourceContainer = try container.nestedContainer(keyedBy: Self.SourceKeys, forKey: .source)
        
        self.media = try sourceContainer.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
        self.publishedAt = try container.decodeIfPresent(String.self, forKey: .publishedAt) ?? ""
        self.urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage) ?? ""
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: Self.ArticleKeys)
        var sourceContainer = container.nestedContainer(keyedBy: Self.SourceKeys, forKey: .source)
        
        try sourceContainer.encode(media, forKey: .name)
        try container.encode(title, forKey: .title)
        try container.encode(url, forKey: .url)
        try container.encode(publishedAt, forKey: .publishedAt)
        try container.encode(urlToImage, forKey: .urlToImage)
    }
}

struct SearchResult: Codable{
    
    let status: String?
    let articles: [Article]
}
