//
//  Models.swift
//  testProject
//
//  Created by awaleh moussa hassan on 06/11/2020.
//

import Foundation
import UIKit



struct CompleteArticle: Codable, Identifiable{
    
    var id = UUID()
    let rawArticle: RawArticle
    let metadata: Metadata
    var imageData: Data = UIImage(systemName: "globe")!.pngData()!
    
    var formattedDate: String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let dateText = rawArticle.publishedAt, let articleDate = formatter.date(from: dateText)
        else {return "Invalide date"}
        
        let relativeFormatter = RelativeDateTimeFormatter()
        relativeFormatter.unitsStyle = .full
        relativeFormatter.dateTimeStyle = .named
        let formattedDate = relativeFormatter.localizedString(for: articleDate, relativeTo: Date())
        return formattedDate
    }
        
    
}

extension CompleteArticle: Hashable{
    
    static func == (lhs: CompleteArticle, rhs: CompleteArticle) -> Bool {
        return lhs.id == rhs.id
    }
}
