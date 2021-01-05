//
//  LoadingView.swift
//  PYN
//
//  Created by awaleh moussa hassan on 22/12/2020.
//

import SwiftUI

public struct LoadingView: View {
    var size: CGSize
    
    public var body: some View {
        ZStack{
            Circle()
                .fill(Color.yellow)
                .frame(width: size.width, height: size.height)
            LoadingTitleView(size: size)
                .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
          }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(size: CGSize(width: 110, height: 110))
            .previewLayout(.sizeThatFits)
    }
}
