//
//  Set&Collection.swift
//  testProject
//
//  Created by awaleh moussa hassan on 21/11/2020.
//

import Foundation


extension Set where Element == Query {
    
    func getQueryIndex(with title: String) -> Index?{
        return self.firstIndex(where: { $0.title == title})
    }
    
    mutating func removeQueryWith(title: String) -> Query?{
        
        guard let queryIndex = self.getQueryIndex(with: title)
        else {return nil}
        return self.remove(at: queryIndex)
    }
    
    mutating func reInsert(_ query: Query){
        let queryToInsert = Query(title: query.title,articles: query.articles)
        self.insert(queryToInsert)
    }
    
    mutating func updatesResults(with article: CompleteArticle,
                                 removeArticle: Bool = false) -> CompleteArticle?{
        
        let title = article.metadata.title
        guard var query = self.removeQueryWith(title: title) else {return nil}
        guard let articleIndex = query.articles.getIndex(of: article)
        else {self.reInsert(query); return nil}
        
        if removeArticle{
            query.articles.remove(at: articleIndex)
        }else{
            query.articles[articleIndex] = article
        }

        let newQuery = Query(title: query.title, articles: query.articles)
        
        if !newQuery.articles.isEmpty{
            self.insert(newQuery)
        }
        
        return (removeArticle == false ? newQuery.articles[articleIndex] : nil)

    }
    
}

extension Collection where Element == CompleteArticle {
    
    func getIndex(of completeArticle: CompleteArticle) -> Self.Index?{
        return self.firstIndex(where: { $0.id == completeArticle.id})
    }
}
