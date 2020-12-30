//
//  Errors_T.swift
//  testProject
//
//  Created by awaleh moussa hassan on 07/11/2020.
//

import Foundation

public protocol CustomError: Error, CustomStringConvertible{}

public enum ArticleError: CustomError{
    
    case emptyArticlesList(String), articleWithNils, convertingToDateError, downloadImageFailed
    
    public var description: String{
        switch self{
        case .emptyArticlesList(let forQuery):
            return "Got no articles for \(forQuery)"
        case .downloadImageFailed:
            return "Failed to download image"
        default:
            return "Unknown error occured"
        }
    }
}

public enum NetworkError: CustomError{
    
    case network
    case parsing(String)
    case unknown(Swift.Error)
    
    public var description: String{
        switch self{
        case .network:
            return "A networking error occured, please check if you have internet."
        case .parsing(let queryItem):
            return "Received bad data for \(queryItem), please retry later."
        case .unknown:
            return "An unknown error occured"
        }
    }
    
    init(error: Swift.Error, query: String){
        
        print(error)
        
        switch error{
        case is URLError:
            self = .network
        case is DecodingError:
            self = .parsing(query)
        default:
            self = .unknown(error.localizedDescription)
        }
    }
}
