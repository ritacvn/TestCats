//
//  CatsListItem.swift
//  CatsTest
//
//  Created by Rita Vasconcelos on 10/02/25.
//
import SwiftUI

struct CatsFeedItem: View {
    let cat: CatData

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: cat.url)) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                        .clipped()
                        .accessibilityLabel("Image of a cat of the breed \(cat.breeds?.first?.name ?? "unknown")")
                } placeholder: {
                    ZStack {
                        Color.gray.opacity(0.2)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 10))

                        ProgressView()
                            .scaleEffect(1.5)
                            .accessibilityLabel("Loading cat image")
                    }
                }

                if let breed = cat.breeds?.first {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(breed.name)
                            .font(.title2)
                            .bold()
                            .foregroundColor(.primary)
                            .fixedSize(horizontal: false, vertical: true)

                        Text(breed.temperament)
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.yellow.opacity(0.15))
                            )
                            .multilineTextAlignment(.center)
                            .accessibilityLabel("Temperament: \(breed.temperament))")

                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                } else {
                    Text("No breed info")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding()
                        .accessibilityLabel("No breed info available")
                }
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
            .frame(maxWidth: 360)
        }
        .padding(.horizontal) 
    }
   }

