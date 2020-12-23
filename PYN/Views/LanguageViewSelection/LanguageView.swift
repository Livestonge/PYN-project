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
    
    var stack: some View {
        return VStack {
            Text("Please choose a language")
                .font(.headline)
                .padding(.top, 10)
            LanguagePickerV(index: $index)
            DidSelectLanguageBt(index: index,
                                action: action)
              .padding(.bottom, 10)
      }
    }
    
    public var body: some View {
        return ModifiedContent(content: stack,
                                modifier: LanguageVStackMdf())
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
    }
}
