//
//  LoadingView.swift
//  PYN
//
//  Created by awaleh moussa hassan on 22/12/2020.
//

import SwiftUI

public struct LoadingView: View {
    public var body: some View {
        ZStack{
            Circle()
                .fill(Color.yellow)
                .frame(width: 110, height: 110, alignment: .center)
            LoadingTitleView()
                .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
          }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
