//
//  LoadingView.swift
//  PYN
//
//  Created by awaleh moussa hassan on 22/12/2020.
//

import SwiftUI

public struct LoadingView: View {
    var size =  CGSize(width: 110, height: 110)
    
    public var body: some View {
        ZStack{
            Circle()
                .fill(Color.yellow)
                .frame(width: size.width, height: size.height)
            LoadingTitleView(size: size)
          }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
            .previewLayout(.sizeThatFits)
    }
}
