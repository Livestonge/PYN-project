//
//  LanguageObjExt.swift
//  PYN
//
//  Created by awaleh moussa hassan on 06/12/2020.
//

import Foundation

public extension Language{
    
    static subscript(index: Int) -> String{
        return Language.allCases[index].rawValue
        
    }
    
    static func firstIndexOf(_ language: Language) -> Int{
        return Language.allCases.firstIndex(where: {$0 == language})!
    }
    
    static func findLanguage(for rawvalue: String) -> Language?{
        return Language.allCases.first(where: {$0.rawValue == rawvalue})!
    }
}
