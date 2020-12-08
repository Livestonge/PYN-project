//
//  Metadata.swift
//  PYN
//
//  Created by awaleh moussa hassan on 07/12/2020.
//

import Foundation


extension Metadata: Hashable{
    
    static func ==(lhs: Metadata, rhs: Metadata)->Bool{
        return lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}
