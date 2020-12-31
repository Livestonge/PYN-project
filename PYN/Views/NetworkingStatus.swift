//
//  NetworkingStatus.swift
//  PYN
//
//  Created by awaleh moussa hassan on 29/12/2020.
//

import SwiftUI

struct NetworkingStatus: View {
    
    var body: some View {
        VStack{
            Text("OOPS")
                .font(.headline)
                .foregroundColor(.red)
            Text("Something went wrong")
                .foregroundColor(.primary)
                .font(.subheadline)
            Text("Please check your internet connection.")
                .foregroundColor(.primary)
                .font(.subheadline)
        }
        
    }
}

struct NetworkingStatus_Previews: PreviewProvider {
    static var previews: some View {
        NetworkingStatus()
    }
}
