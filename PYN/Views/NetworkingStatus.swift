//
//  NetworkingStatus.swift
//  PYN
//
//  Created by awaleh moussa hassan on 29/12/2020.
//

import SwiftUI

struct NetworkingStatus: View {
    
    var body: some View {
        VStack(alignment: .center){
            Text("OOPS")
                .font(.headline)
                .foregroundColor(.red)
            Text("Something went wrong.\n Please check your internet connction.")
                .multilineTextAlignment(.center)
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
