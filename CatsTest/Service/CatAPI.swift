//
//  CatAPI.swift
//  CatsTest
//
//  Created by Rita Vasconcelos on 10/02/25.
//

import Foundation

import Foundation

enum CatAPI {
    private static let baseURL = "https://api.thecatapi.com/v1/images/search"

    static func getCatImagesURL(
        limit: Int = 10,
        page: Int = 0,
        order: String = "RAND",
        hasBreeds: Int = 1,
        breedIDs: String? = nil,
        categoryIDs: String? = nil,
        subID: String? = nil
    ) -> URL? {
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "order", value: order),
            URLQueryItem(name: "has_breeds", value: "\(hasBreeds)")
        ]

        if let breedIDs = breedIDs {
            components?.queryItems?.append(URLQueryItem(name: "breed_ids", value: breedIDs))
        }
        if let categoryIDs = categoryIDs {
            components?.queryItems?.append(URLQueryItem(name: "category_ids", value: categoryIDs))
        }
        if let subID = subID {
            components?.queryItems?.append(URLQueryItem(name: "sub_id", value: subID))
        }

        return components?.url
    }
}
