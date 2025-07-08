//
//  ContentView.swift
//  SUI-HW7
//
//  Created by Dim on 08.07.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
    ]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.news) { one in
                    PostView(title: one.title, price: 2.34, volume: 350, imageUrl: one.thumbImageStringUrl)
                }
            }
            .padding()
        }
        .background(.ultraThickMaterial)
        .onAppear() {
            viewModel.fetchData()
        }
    }
}

#Preview {
    ContentView()
}
