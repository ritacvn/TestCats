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
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading cats...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 16) {
                            ForEach(viewModel.catImages) { cat in
                                NavigationLink(destination: CatDetailView(cat: cat)) {
                                    CatGridItem(cat: cat)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("🐱 Cat Gallery")
            .task {
                viewModel.fetchCatImages()
            }
        }
    }
}

struct CatGridItem: View {
    let cat: CatImage

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: cat.url)) { image in
                image.resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } placeholder: {
                ProgressView()
                    .frame(width: 150, height: 150)
            }
            if let breed = cat.breeds?.first {
                Text(breed.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .padding(.top, 5)
            } else {
                Text("Sem raça")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
