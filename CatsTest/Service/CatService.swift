//
//  CatService.swift
//  CatsTest
//
//  Created by Rita Vasconcelos on 10/02/25.
//

import Foundation

class CatService {
    private let baseURL = "https://api.thecatapi.com/v1/images/search"
    private let apiKey = "live_NjrBZ64QSFdojA9axnoJF71FQoa2g1NFb1y8p3YL6rRKorzRklvlreoEXhXys8pW"

    func fetchCatImages(limit: Int, page: Int, completion: @escaping (Result<[CatImage], Error>) -> Void) {
        let urlString = "\(baseURL)?limit=\(limit)&has_breeds=1&page=\(page)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "x-api-key")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "Empty data", code: 204, userInfo: nil)))
                return
            }

            do {
                let decodedCats = try JSONDecoder().decode([CatImage].self, from: data)
                completion(.success(decodedCats))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
