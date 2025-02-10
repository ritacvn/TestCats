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
            AsyncImage(url: URL(string: cat.url)) { image in
                image.resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } placeholder: {
                ProgressView()
                    .frame(height: 300)
            }
            
            if let breed = cat.breeds?.first {
                Text(breed.name)
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)

                Text("Origin: \(breed.origin)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text("Temperament: \(breed.temperament)")
                    .font(.body)
                    .padding()
            } else {
                Text("Breed info not available")
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Cat details")
    }
}
