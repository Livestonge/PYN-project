//
//  Objects.swift
//  testProject
//
//  Created by awaleh moussa hassan on 06/11/2020.
//

import Foundation
import UIKit
import Combine


class Networking {
    
    deinit {
        print("Networking object  deallocated!!!!")
    }
    
    func fetchData(query: String, language: Languages) -> AnyPublisher<[CompleteArticle], Error>{
        
        
        guard let url = self.prepareUrlFor(query, for: language) else {
            fatalError("Url Not Found")
        }
        
        return  URLSession.shared.dataTaskPublisher(for: url)
                            .tryMap{ result in
                                guard let response = result.response as? HTTPURLResponse else {throw NetworkError.network}
                                guard (200..<300).contains(response.statusCode) else { throw NetworkError.network}
                                return result.data
                            }
                            .decode(type:SearchResult.self, decoder: JSONDecoder())
                            .mapError({NetworkError(error: $0, query: query)})
                            .map(\.articles)
                            .map{ (article: [RawArticle]) -> ([RawArticle], String) in
                                return (article, query)
                            }
                            .flatMap(instantiateCompleteArticles)
                            .eraseToAnyPublisher()
    }
    
    
     private func prepareUrlFor(_ query: String, for language: Languages) ->URL?{
        
        let searchParameters = [
                                "q": query,
                                "language": language.initials,
                                "sortBy": "publishedAt",
                                "apiKey": "\(URL.apiKey)"
                               ]
        
        var components = URLComponents(string: "https://newsapi.org/v2/everything")
        components!.queryItems = searchParameters.map{(key, value) -> URLQueryItem in
            URLQueryItem(name: key, value: value)
        }
        
        return components?.url
    }
    
    //@available(iOS 14.0, *)
    func instantiateCompleteArticles(for rawArticles: [RawArticle],
                                     and queryTitle: String) -> AnyPublisher<[CompleteArticle], Never>{
        
        return rawArticles.publisher
                              .map({ (rawArticle: RawArticle) -> CompleteArticle in
                                return CompleteArticle(rawArticle: rawArticle, query: queryTitle)
                               })
                               .collect()
                               .eraseToAnyPublisher()
    }

    
}
