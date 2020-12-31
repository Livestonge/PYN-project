//
//  Objects.swift
//  testProject
//
//  Created by awaleh moussa hassan on 06/11/2020.
//

import Foundation
//import UIKit
import Combine


class Networking {
    
    
    private lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForResource = 3
        let session = URLSession(configuration: config)
        return session
    }()
    
    
    func fetchData(query: String, language: Language) -> AnyPublisher<[CompleteArticle], NetworkError>{
        
        
        guard let url = self.prepareUrlFor(query, for: language) else {
            fatalError("Url Not Found")
        }
        
        return  self.session.dataTaskPublisher(for: url)
                            .retry(1)
                            .tryMap{ result in
                                guard let response = result.response as? HTTPURLResponse,
                                      (200..<300).contains(response.statusCode) else {throw NetworkError.badServerResponse}
                                return result.data
                            }
                            .decode(type:SearchResult.self, decoder: JSONDecoder())
                            .mapError{NetworkError.init(error: $0)}
                            .map(\.articles)
                            .map{ (article: [RawArticle]) -> ([RawArticle], String, Language) in
                                return (article, query, language)
                            }
                            .flatMap(instantiateCompleteArticles)
                            .eraseToAnyPublisher()
    }
    
    
     private func prepareUrlFor(_ query: String, for language: Language) ->URL?{
        
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
                                     and queryTitle: String,
                                     language: Language) -> AnyPublisher<[CompleteArticle], Never>{
        
        return rawArticles.publisher
            //Storing only article with non nil url address.
                              .filter({$0.url != nil})
                              .map({ (rawArticle: RawArticle) -> CompleteArticle in
                                return CompleteArticle(rawArticle: rawArticle,
                                                       metadata: Metadata(title: queryTitle,
                                                                          fetchDate: Date(),
                                                                          language: language))
                               })
                              .collect()
                              .eraseToAnyPublisher()
    } 
}
