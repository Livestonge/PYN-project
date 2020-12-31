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
            Text("OOPS...")
                .foregroundColor(.red)
            Text("There is a bad connection")
            Text("Please check your internet.")
        }
        
        
            
            
    }
}

struct NetworkingStatus_Previews: PreviewProvider {
    static var previews: some View {
        NetworkingStatus()
    }
}
