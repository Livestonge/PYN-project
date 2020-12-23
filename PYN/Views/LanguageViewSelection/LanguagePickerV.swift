//
//  LanguagePickerV.swift
//  PYN
//
//  Created by awaleh moussa hassan on 23/12/2020.
//

import SwiftUI

public struct LanguagePickerV: View{
    
    @Binding var index: Int
    public var body: some View {
        
        Picker("", selection: self.$index){
             ForEach(0 ..< Languages.allCases.count){
                Text(Languages[$0])
                    .foregroundColor(($0 == index ? .yellow : .black))
              }
           }
    }
}

struct LanguagePickerV_Previews: PreviewProvider {
    static var previews: some View {
        LanguagePickerV(index: .constant(0))
            .previewLayout(.sizeThatFits)
    }
}
