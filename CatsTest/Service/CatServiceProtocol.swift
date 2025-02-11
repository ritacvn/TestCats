//
//  CatServiceProtocol.swift
//  CatsTest
//
//  Created by Rita Vasconcelos on 10/02/25.
//

import Foundation

protocol CatServiceProtocol {
    func fetchCatImages(
        options: CatFetchOptions.Parameters,
        completion: @escaping (Result<[CatData], CatServiceError>) -> Void
    )
}
