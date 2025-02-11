//
//  CatService.swift
//  CatsTest
//
//  Created by Rita Vasconcelos on 10/02/25.
//

import Foundation

class CatService: CatServiceProtocol {
    private let apiKey: String
    private let session: URLSession

    init(apiKey: String = SecretsManager.getAPIKey() ?? "",
         session: URLSession = .shared) {
        self.apiKey = apiKey
        self.session = session
    }

    func fetchCatImages(
        limit: Int = 10,
        page: Int = 0,
        order: String = "RAND",
        hasBreeds: Int = 1,
        breedIDs: String? = nil,
        categoryIDs: String? = nil,
        subID: String? = nil,
        completion: @escaping (Result<[CatData], Error>) -> Void
    ) {
        guard let url = CatAPI.getCatImagesURL(
            limit: limit,
            page: page,
            order: order,
            hasBreeds: hasBreeds,
            breedIDs: breedIDs,
            categoryIDs: categoryIDs,
            subID: subID
        ) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "x-api-key")

        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "Empty data", code: 204, userInfo: nil)))
                return
            }

            do {
                let decodedCats = try JSONDecoder().decode([CatData].self, from: data)
                completion(.success(decodedCats))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
