//
//  DidSelectLanguageBt.swift
//  PYN
//
//  Created by awaleh moussa hassan on 23/12/2020.
//

import SwiftUI

public struct DidSelectLanguageBt: View {
    
    var index: Int
    var action: ()->Void
    @Environment(\.colorScheme) var colorScheme
    
    public var body: some View {
        Button(action: {
          self.action()
          
      }){
          Text("Placeholder!!!!!")
            .font(Font.headline.bold())
            .hidden()
            .padding()
            .overlay(
                  HStack{
                      Text("\(Language[self.index])")
                     .font(.headline)
                     Image(systemName: "hand.thumbsup")
                     }
                  .foregroundColor(colorScheme == .dark ? .yellow : .primary)
                )
            .background(colorScheme == .dark ? .orange : Color(UIColor.systemBlue))
            .clipShape(Capsule())
            .padding(.bottom, 10)
               
                
                
                
         
      }
    }
}

struct DidSelectLanguageBt_Previews: PreviewProvider {
    static var previews: some View {
        DidSelectLanguageBt(index: 1, action: {})
            .previewLayout(.sizeThatFits)
            .colorScheme(.light)
    }
}
