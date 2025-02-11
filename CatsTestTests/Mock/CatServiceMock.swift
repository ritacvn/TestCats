//
//  CatServiceMock.swift
//  CatsTestTests
//
//  Created by Rita Vasconcelos on 11/02/25.
//
import Foundation

class CatServiceMock: CatServiceProtocol {
    var mockResult: Result<[CatData], CatServiceError>?

    func fetchCatImages(options: CatFetchOptions.Parameters, completion: @escaping (Result<[CatData], CatServiceError>) -> Void) {
        if let result = mockResult {
            completion(result)
        }
    }
}
