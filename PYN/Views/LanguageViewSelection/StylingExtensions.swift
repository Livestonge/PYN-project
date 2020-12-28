//
//  LanguageViewMdf.swift
//  PYN
//
//  Created by awaleh moussa hassan on 23/12/2020.
//

import Foundation
import SwiftUI


extension VStack{
    
    func languageStackStyling() -> some View{
        
        self.background(Color(UIColor.systemBackground))
            .cornerRadius(20)
            .shadow(color: .black,
                   radius: 10,
                   x: .zero,
                   y: .zero)
    }
}
