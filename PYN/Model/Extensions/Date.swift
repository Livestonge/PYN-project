//
//  Date.swift
//  PYN
//
//  Created by awaleh moussa hassan on 08/12/2020.
//

import Foundation


extension Date{
    
    var isOldData: Bool{
        return self.addingTimeInterval(3600) < Date()
    }
}
