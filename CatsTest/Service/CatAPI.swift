//
//  CatAPI.swift
//  CatsTest
//
//  Created by Rita Vasconcelos on 10/02/25.
//

import Foundation

import Foundation

enum CatAPI {
    private static let baseURL = APIConfig.baseURL

    static func getCatImagesURL(
        options: CatFetchOptions.Parameters = .default
    ) -> URL? {
        var components = URLComponents(string: "\(baseURL)/images/search")
        components?.queryItems = [
            URLQueryItem(name: "limit", value: "\(options.limit)"),
            URLQueryItem(name: "page", value: "\(options.page)"),
            URLQueryItem(name: "order", value: options.order.rawValue),
            URLQueryItem(name: "has_breeds", value: "\(options.hasBreeds)")
        ]

        if let breedIDs = options.breedIDs {
            components?.queryItems?.append(URLQueryItem(name: "breed_ids", value: breedIDs))
        }
        if let categoryIDs = options.categoryIDs {
            components?.queryItems?.append(URLQueryItem(name: "category_ids", value: categoryIDs))
        }
        if let subID = options.subID {
            components?.queryItems?.append(URLQueryItem(name: "sub_id", value: subID))
        }

        return components?.url
    }
}
