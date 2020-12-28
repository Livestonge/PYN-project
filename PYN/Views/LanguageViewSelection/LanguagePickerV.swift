//
//  LanguagePickerV.swift
//  PYN
//
//  Created by awaleh moussa hassan on 23/12/2020.
//

import SwiftUI

public struct LanguagePickerV: View{
    
    @Environment(\.colorScheme) var colorScheme
    @Binding var index: Int
    public var body: some View {
        VStack{
            Text("Please choose a language")
                .font(Font.headline.bold())
                .padding(.top, 10)
            Picker("", selection: self.$index){
                 ForEach(0 ..< Languages.allCases.count){
                    Text(Languages[$0])
                        .foregroundColor((colorScheme == .dark ? .yellow : .black))
                  }
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
