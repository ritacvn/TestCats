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
        VStack {
            ScrollView {
                VStack(spacing: 16) {
                    AsyncImage(url: URL(string: cat.url)) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1.5)
                            )
                            .shadow(color: Color.yellow.opacity(0.3), radius: 5, x: 0, y: 3)
                            .accessibilityLabel("image of a cat of the breed \(cat.breeds?.first?.name ?? "unknown")")
                    } placeholder: {
                        ProgressView()
                            .frame(height: 300)
                            .accessibilityLabel("Loading cat image")
                    }

                    if let breed = cat.breeds?.first {
                        Text("🌍 \(breed.origin)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .accessibilityLabel("Origin: \(breed.origin)")

                        Text("\(breed.temperament)")
                            .font(.subheadline)
                            .italic()
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                            .accessibilityLabel("Temperament: \(breed.temperament)")

                        HStack {
                            if let lifeSpan = breed.lifeSpan {
                                InfoRow(label: "⏳ Life span",
                                        value: "\(lifeSpan) years")
                                .accessibilityLabel("Life span: \(lifeSpan) years")
                            }
                            if let weight = breed.weight?.metric {
                                InfoRow(label: "⚖️ Weight",
                                        value: "\(weight) kg")
                                .accessibilityLabel("Weight: \(weight) kg")
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

                    Spacer()
                }
                .padding()
            }

            if let wikipediaURL = cat.breeds?.first?.wikipediaURL, let url = URL(string: wikipediaURL) {
                Link(destination: url) {
                    HStack {
                        Image(systemName: "globe")
                        Text("🔗 Learn more on wikipedia")
                            .font(.headline)
                            .bold()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.yellow.opacity(0.2))
                    .foregroundColor(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 5)
                }
                .padding()
            }
        }
        .background(Color(uiColor: .systemGray6))
        .navigationTitle(cat.breeds?.first?.name ?? "Cat details")
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
