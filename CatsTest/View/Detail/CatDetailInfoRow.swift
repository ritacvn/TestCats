//
//  InfoRow.swift
//  CatsTest
//
//  Created by Rita Vasconcelos on 10/02/25.
//

import Foundation
import SwiftUI

struct CatDetailInfoRow: View {
    let label: String
    let value: String

    var body: some View {
        VStack {
            Text(label)
                .font(.headline)
                .bold()
                .foregroundColor(.primary)
            Text(value)
                .font(.subheadline)
                .bold()
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}
