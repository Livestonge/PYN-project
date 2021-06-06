//
//  Article.swift
//  PYN
//
//  Created by Awaleh  on 06/06/2021.
//

import Foundation


extension Article: Codable {
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: Self.ArticleKeys)
        let sourceContainer = try container.nestedContainer(keyedBy: Self.SourceKeys, forKey: .source)
        
        self.media = try sourceContainer.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
        self.publishedAt = try container.decodeIfPresent(String.self, forKey: .publishedAt) ?? ""
        self.urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage) ?? ""
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: Self.ArticleKeys)
        var sourceContainer = container.nestedContainer(keyedBy: Self.SourceKeys, forKey: .source)
        
        try sourceContainer.encode(media, forKey: .name)
        try container.encode(title, forKey: .title)
        try container.encode(url, forKey: .url)
        try container.encode(publishedAt, forKey: .publishedAt)
        try container.encode(urlToImage, forKey: .urlToImage)
    }
}
