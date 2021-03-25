//
//  Languages.swift
//  FNews
//
//  Created by awaleh moussa hassan on 16/09/2020.
//  Copyright © 2020 awaleh moussa hassan. All rights reserved.
//

import Foundation

public enum Language: String, CaseIterable, Codable, Hashable{
    
    case French, English, Spanish, Norwegian, Italian, Somali
    
    var initials: String {
        let initial = self.rawValue.prefix(2)
        return initial.lowercased()
    }
}
