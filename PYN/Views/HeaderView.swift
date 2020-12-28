//
//  HeaderView.swift
//  testProject
//
//  Created by awaleh moussa hassan on 10/11/2020.
//

import SwiftUI

struct HeaderView: View {
    
    var title: String
    var body: some View {
        Text(title)
            .font(.headline)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Oslo")
            .previewLayout(.sizeThatFits)
    }
}
