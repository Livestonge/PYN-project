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


enum CoreDataError: CustomError{
    case savingError(String), deletingError(String), uploadingsError(String)
    
    public var description: String{
        switch self{
        case .savingError(let item):
            return "Could not save \(item)"
        case .deletingError(let message):
            return "Could not delete \(message)"
        case .uploadingsError(let message):
            return "Could not upload \(message)"
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
            self = error as? NetworkError ?? .unknown(error)
        }
    }
}
