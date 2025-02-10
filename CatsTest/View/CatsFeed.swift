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
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 3)
                    )
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
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color.gray)
                    .frame(width: 100, height: 3)
                    .padding(.top, 2)
            } else {
                Text("Unknown breed")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
