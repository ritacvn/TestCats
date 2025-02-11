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
                    catList

                    if viewModel.isLoading && !viewModel.catImages.isEmpty {
                        LoadingIndicator()
                    }
                }
                .padding(.vertical)
            }
            .background(Color(uiColor: .systemGray6))
            .navigationTitle("🐱 Cats Gallery")
            .onAppear { viewModel.loadInitialCats() }
        }
    }

    private var catList: some View {
        ForEach(viewModel.catImages.indices, id: \.self) { index in
            let cat = viewModel.catImages[index]
            NavigationLink(destination: CatDetailView(cat: cat)) {
                CatsFeedItem(cat: cat)
                    .padding(.horizontal)
            }
            .onAppear { viewModel.loadMoreCats(index) }
        }
    }
}

struct LoadingIndicator: View {
    var body: some View {
        ProgressView("Loading...")
            .accessibilityIdentifier("Loading") 
            .padding()
    }
}
