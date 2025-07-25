//
//  PostView.swift
//  SUI-HW7
//
//  Created by Dim on 08.07.2025.
//

import SwiftUI

struct PostView: View {
    let title: String
    let price: Float
    let volume: Float
    let imageUrl: String
    
    var body: some View {
        VStack {
            GeometryReader { geom in
                AsyncImage(url: URL(string: imageUrl)!) { $0
                    .resizable()
                    .scaledToFill()
                    .frame(width: geom.size.width, height: geom.size.width)
                    .clipped()
                } placeholder: {
                    ProgressView()
                        .frame(width: geom.size.width, height: geom.size.width)
                }
            }
            .aspectRatio(1, contentMode: .fit)
            
            VStack {
                HStack {
                    Text(title)
                        .lineLimit(2)
                    Spacer()
                    Image(systemName: "star")
                }
                
                Rectangle()
                    .background(.gray)
                    .frame(height: 1)
                    .padding(.bottom, 6)
                
                HStack {
                    HStack {
                        Text(String(format: "%.2f", price))
                            .lineLimit(1)
                        Text("₽")
                    }
                    .frame(minWidth: 55)
                    .priceStyle()
                    
                    Spacer()
                    Text(String(format: "%.0f", volume) + " ml")
                        .lineLimit(1)
                }
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 12)
        }
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
