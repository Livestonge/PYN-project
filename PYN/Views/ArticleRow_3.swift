//
//  ArticleRow_3.swift
//  testProject
//
//  Created by awaleh moussa hassan on 06/11/2020.
//

import SwiftUI

struct ArticleRow_3: View {
    
    @Environment(\.colorScheme) var colorScheme
    let imageData: Data
    let title: String
    let source: String
    let date: String
    
    var body: some View {
        
        return HStack(alignment: .center){
            Image(uiImage: UIImage(data: imageData)!)
                .resizable()
                .frame(width: 50, height: 50)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
            VStack(alignment: .leading){
                Text(title)
                    .font(.headline)
                    .lineLimit(2)
                    .allowsTightening(true)
                HStack {
                    Text(source)
                        .foregroundColor( colorScheme == .dark ? .yellow : .green)
                        .fontWeight(.black)
                    Spacer()
                    Text("\(date)")
                        .allowsTightening(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.secondary)
                }
                .font(.subheadline)
                .padding(.top)
            }
        }
    }
}

struct ArticleRow_preview: PreviewProvider{
   
    static var previews: some View{
        ArticleRow_3(imageData: UIImage(systemName: "globe")!.pngData()!,
                     title: "The end of Covid",
                     source: "CNN",
                     date: "for 10 hours ago")
            .previewLayout(.sizeThatFits)
            .colorScheme(.light)
    }
    
}
