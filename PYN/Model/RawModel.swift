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
    
    
    var formattedDate: String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let dateText = publishedAt, let articleDate = formatter.date(from: dateText) else {return "Invalide date"}
        
        let relativeFormatter = RelativeDateTimeFormatter()
        relativeFormatter.unitsStyle = .full
        relativeFormatter.dateTimeStyle = .named
        let formattedDate = relativeFormatter.localizedString(for: articleDate, relativeTo: Date())
        return formattedDate
    }
}

struct SearchResult: Codable{
    
    let status: String?
    let articles: [RawArticle]
}
