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
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 16) {
                    ForEach(viewModel.catImages.indices, id: \.self) { index in
                        let cat = viewModel.catImages[index]
                        NavigationLink(destination: CatDetailView(cat: cat)) {
                            CatGridItem(cat: cat)
                        }
                        .onAppear {
                            if index == viewModel.catImages.count - 1 { 
                                viewModel.fetchCatImages()
                            }
                        }
                    }
                }
                .padding()
                
                if viewModel.isLoading {
                    ProgressView()
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

