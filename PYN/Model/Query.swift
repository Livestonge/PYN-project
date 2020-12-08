//
//  Query.swift
//  PYN
//
//  Created by awaleh moussa hassan on 08/12/2020.
//

import Foundation

struct Query{
    
    let id = UUID()
    let title: String
    var articles = [CompleteArticle]()
}

extension Query: Hashable {
    
    static func == (lhs: Query, rhs: Query) -> Bool{
        return lhs.id == rhs.id
    }
}
