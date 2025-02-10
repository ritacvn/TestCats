//
//  CatsData.swift
//  CatsTest
//
//  Created by Rita Vasconcelos on 10/02/25.
//

import Foundation

struct CatImage: Codable, Identifiable {
    let id: String
    let url: String
    let breeds: [CatBreed]?
}

struct CatBreed: Codable {
    let id: String
    let name: String
    let temperament: String
    let origin: String
}

