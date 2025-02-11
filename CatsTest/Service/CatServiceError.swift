//
//  CatServiceError.swift
//  CatsTest
//
//  Created by Rita Vasconcelos on 11/02/25.
//

import Foundation

enum CatServiceError: Error, Equatable { 
    case invalidURL
    case emptyData
    case decodingError(Error)
    case networkError(Error)
    
    static func == (lhs: CatServiceError, rhs: CatServiceError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
             (.emptyData, .emptyData):
            return true
        case (.decodingError(let e1), .decodingError(let e2)):
            return e1.localizedDescription == e2.localizedDescription
        case (.networkError(let e1), .networkError(let e2)):
            return e1.localizedDescription == e2.localizedDescription
        default:
            return false
        }
    }
}
