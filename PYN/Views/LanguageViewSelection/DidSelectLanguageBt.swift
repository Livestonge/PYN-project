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
    
    public var body: some View {
        Button(action: {
          self.action()
          
      }){
          Text("Placeholder!!!!!")
              .font(.headline)
              .hidden()
              .background(Color(UIColor.systemTeal))
              .clipShape(Capsule())
              .padding()
              .overlay(
                  HStack{
                      Text("\(Languages[self.index])")
                     .font(.headline)
                     Image(systemName: "hand.thumbsup")
                     }
                  .foregroundColor(Color(UIColor.label))
                )
         
      }
    }
}

struct DidSelectLanguageBt_Previews: PreviewProvider {
    static var previews: some View {
        DidSelectLanguageBt(index: 1, action: {})
            .previewLayout(.sizeThatFits)
    }
}
