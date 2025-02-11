//
//  CatServiceProtocol.swift
//  CatsTest
//
//  Created by Rita Vasconcelos on 10/02/25.
//

import Foundation

protocol CatServiceProtocol {
    func fetchCatImages(
        limit: Int,
        page: Int,
        order: String,
        hasBreeds: Int,
        breedIDs: String?,
        categoryIDs: String?,
        subID: String?,
        completion: @escaping (Result<[CatData], Error>) -> Void
    )
}
