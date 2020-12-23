//
//  LanguageView.swift
//  testProject
//
//  Created by awaleh moussa hassan on 21/11/2020.
//

import SwiftUI

struct LanguagesView: View {
        
        @Binding var index: Int
        @State private var isScaling = false
        var action: () -> Void
        
        var body: some View {
           return  VStack {
               Text("Please choose a language")
                .font(.headline)
                .padding(.top, 10)
            Picker(selection: self.$index, label: Text("")){
                 ForEach(0 ..< Languages.allCases.count){
                    Text(Languages[$0])
                        .foregroundColor(($0 == index ? .yellow : .black))
                  }
               }
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
            .padding(.bottom, 10)
            }
           .background(Color(UIColor.systemBackground))
           .cornerRadius(20)
           .shadow(color: .black,
                  radius: 10,
                  x: .zero,
                  y: .zero)
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
