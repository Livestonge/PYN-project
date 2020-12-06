//
//  Models.swift
//  testProject
//
//  Created by awaleh moussa hassan on 06/11/2020.
//

import Foundation
import UIKit



struct CompleteArticle: Codable, Identifiable, Hashable{
    
    static func == (lhs: CompleteArticle, rhs: CompleteArticle) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    var id = UUID()
    let rawArticle: RawArticle
    let query: String
    var imageData: Data?
    
    var formattedDate: String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let dateText = rawArticle.publishedAt, let articleDate = formatter.date(from: dateText) else {return "Invalide date"}
        
        let relativeFormatter = RelativeDateTimeFormatter()
        relativeFormatter.unitsStyle = .full
        relativeFormatter.dateTimeStyle = .named
        let formattedDate = relativeFormatter.localizedString(for: articleDate, relativeTo: Date())
        return formattedDate
    }
    
    mutating func downloadImage(){
        guard let path = rawArticle.urlToImage, let url = URL(string: path),
              let content = try? Data(contentsOf: url),
              let data = UIImage(data: content) else {return}
        
        self.imageData = data.pngData()
    }
        
    
}

struct Query: Hashable{
    
    static func == (lhs: Query, rhs: Query) -> Bool{
        return lhs.id == rhs.id
    }
    
    let id = UUID()
    let title: String
    var articles = [CompleteArticle]()
}

enum ArticleUpdate{
    case articleRemoval, imageUpdate(UIImage?)
}
