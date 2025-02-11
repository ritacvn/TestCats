//
//  ContentView.swift
//  CatsTest
//
//  Created by Rita Vasconcelos on 09/02/25.
//

import SwiftUI

struct CatsFeed: View {
    @StateObject private var viewModel = CatViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.catImages.indices, id: \.self) { index in
                        let cat = viewModel.catImages[index]
                        NavigationLink(destination: CatDetailView(cat: cat)) {
                            CatsFeedItem(cat: cat)
                                .padding(.horizontal)
                        }
                        .onAppear {
                            if index == viewModel.catImages.count - 1 {
                                viewModel.fetchCatImages()
                            }
                        }
                    }
                }
                .padding(.vertical)
                
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .padding()
                }
            }
            .background(Color(uiColor: .systemGray6)) 
            .navigationTitle("🐱 Cats Gallery")
            .task {
                viewModel.fetchCatImages()
            }
        }
    }
}
