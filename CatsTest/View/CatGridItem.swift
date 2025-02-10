//
//  CatGridItem.swift
//  CatsTest
//
//  Created by Rita Vasconcelos on 10/02/25.
//

import SwiftUI

struct CatGridItem: View {
    let cat: CatImage

    var body: some View {
        VStack {
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
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .padding(.top, 5)

                    Text(breed.temperament)
                        .font(.footnote)
                        .foregroundColor(.black)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.3))
                        )
                        .lineLimit(3)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 140)
                        .padding(.top, 2)
                } else {
                    Text("No breed info")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
        }
    }
}
