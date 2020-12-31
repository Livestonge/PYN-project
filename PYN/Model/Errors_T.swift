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
    
    case badServerResponse
    case badConnection
    case decodingError
    case unknown(String)
    
    public var description: String{
        switch self{
        case .badConnection:
            return "A networking error occured,\n Please check if you have internet."
        case .badServerResponse:
            return "Did receive bad response from server,\n Please try again."
        case .decodingError:
            return "Unable to parse received data,\n Please make a new search. "
        default:
            return "An unknown error occured"
        }
    }
    
    init(error: Error){
        
        switch error{
        
        case is URLError:
            self = .badConnection
        case NetworkError.badConnection:
            self = .badServerResponse
        case is Swift.DecodingError:
            self = .decodingError
        default:
            self = .unknown(error.localizedDescription)
        }
    }
}
