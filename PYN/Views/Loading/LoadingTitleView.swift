//
//  LoadingView.swift
//  GeometryShapes
//
//  Created by awaleh moussa hassan on 16/12/2020.
//

import SwiftUI

struct LoadingTitleView: View {
    
    @State var isScaling = false
    
    var body: some View {
        
        return Text("Loading")
                .font(.body)
                .foregroundColor(.white)
                .frame(width: 100,
                       height: 100)
                .background(Color.black)
                .clipShape(Circle())
                .shadow(radius: 4)
                .scaleEffect(((isScaling ? CGSize(width: 1.0, height: 1.0) : CGSize(width: 0, height: 1.0))))
                .onAppear(perform: {
                    withAnimation(
                        Animation.easeInOut(duration: 1).repeatForever()){
                        isScaling.toggle()
                    }
                    
                 })
  }
    
}

struct LoadingTitleView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingTitleView(isScaling: false)
            .previewLayout(.sizeThatFits)
    }
}
