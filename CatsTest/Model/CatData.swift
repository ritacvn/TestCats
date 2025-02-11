//
//  CatsData.swift
//  CatsTest
//
//  Created by Rita Vasconcelos on 10/02/25.
//

import Foundation

struct CatData: Codable, Identifiable {
    let id: String
    let url: String
    let breeds: [CatBreed]?
}

struct CatBreed: Codable {
    let id: String
    let name: String
    let temperament: String
    let origin: String
    let lifeSpan: String?
    let description: String?
    let weight: CatWeight?
    let wikipediaURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name, temperament, origin
        case lifeSpan = "life_span"
        case description
        case weight
        case wikipediaURL = "wikipedia_url" 
    }
}

struct CatWeight: Codable {
    let metric: String
}
