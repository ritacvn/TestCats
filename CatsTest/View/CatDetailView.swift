//
//  CatDetailView.swift
//  CatsTest
//
//  Created by Rita Vasconcelos on 10/02/25.
//

import SwiftUI

struct CatDetailView: View {
    let cat: CatImage

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                AsyncImage(url: URL(string: cat.url)) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1.5)                         )
                        .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 3)
                } placeholder: {
                    ProgressView()
                        .frame(height: 300)
                }

                if let breed = cat.breeds?.first {
                    VStack {
                        Text("🌍 \(breed.origin) \n 😺 \(breed.temperament)")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.primary)
                    }
                    .padding(.top, 5)
                    .frame(maxWidth: .infinity)
                    HStack {
                        if let lifeSpan = breed.lifeSpan {
                            InfoRow(label: "⏳ Life span",
                                    value: "\(lifeSpan) years")
                        }
                        if let weight = breed.weight?.metric {
                            InfoRow(label: "⚖️ Weight",
                                    value: "\(weight) kg")
                        }
                    }
                    .padding(.top, 10)
                    Text("📖 About:")
                        .font(.headline)
                        .bold()
                        .padding(.top, 10)
                        .frame(maxWidth: .infinity, alignment: .center)

                    if let description = breed.description {
                        Text(description)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal)
                    }
                } else {
                    Text("Breed info not available")
                        .foregroundColor(.gray)
                }
            }
            .padding()
        }
        .background(Color(uiColor: .systemGray6))
        .navigationTitle(cat.breeds?.first?.name ?? "Cat details")
    }
}
