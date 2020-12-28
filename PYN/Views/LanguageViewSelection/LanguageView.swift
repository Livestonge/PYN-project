//
//  LanguageView.swift
//  testProject
//
//  Created by awaleh moussa hassan on 21/11/2020.
//

import SwiftUI

public struct LanguagesView: View {
        
    @Binding var index: Int
    @State private var isScaling = false
    var action: () -> Void
    
    public var body: some View {
        
        return VStack {
                    LanguagePickerV(index: $index)
                    DidSelectLanguageBt(index: index,
                                action: action)
                   }
                    .languageStackStyling()
                    .scaleEffect(isScaling ? 1 : 0)
                            .onAppear(perform: {
                                withAnimation(Animation.easeOut(duration: 2)){
                                    isScaling.toggle()
                                }
                           })
        }
}

struct LanguageView_Previews: PreviewProvider {
    
    static var previews: some View {
        LanguagesView(index: .constant(3),
                      action: {})
            .colorScheme(.dark)
    }
}
