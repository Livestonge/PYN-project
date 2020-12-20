//
//  LoadingView.swift
//  GeometryShapes
//
//  Created by awaleh moussa hassan on 16/12/2020.
//

import SwiftUI

struct LoadingView: View {
    
    @State var isScaling = false
    
    var body: some View {
        return Text("Loading")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .frame(width: 150,
                       height: 150)
                .background(Color.black)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.yellow, lineWidth: 4))
                .shadow(radius: 4)
                .scaleEffect((!isScaling ? 1 : 0))
                .animation(Animation.easeInOut(duration: 1.0).repeatForever())
                .onAppear(perform: {
                    isScaling.toggle()
                 })
  }
    
}

//struct LoadingView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoadingView(flag: false)
//    }
//}
