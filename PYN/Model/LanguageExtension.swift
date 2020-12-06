//
//  LanguageExtension.swift
//  testProject
//
//  Created by awaleh moussa hassan on 21/11/2020.
//

import Foundation

public extension Languages{
    
    static subscript(index: Int) -> String{
        return Languages.allCases[index].rawValue
        
    }
    
    static func firstIndexOf(_ language: Languages) -> Int{
        return Languages.allCases.firstIndex(where: {$0 == language})!
    }
    
    static func findLanguage(for rawvalue: String) -> Languages{
        return Languages.allCases.first(where: {$0.rawValue == rawvalue})!
    }
}
