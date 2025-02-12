//
//  CatService.swift
//  CatsTest
//
//  Created by Rita Vasconcelos on 10/02/25.
//

import Foundation

class CatService: CatServiceProtocol {
    private let apiKey: String
    private let session: URLSessionProtocol

    init(apiKey: String = SecretsManager.getAPIKey() ?? "",
         session: URLSessionProtocol = URLSession.shared) {
        self.apiKey = apiKey
        self.session = session
    }

    func fetchCatImages(
        options: CatFetchOptions.Parameters = .default,
        completion: @escaping (Result<[CatData], CatServiceError>) -> Void
    ) {
        guard let url = CatAPI.getCatImagesURL(options: options) else {
            completion(.failure(.invalidURL))
            return
        }

        let request = createRequest(url: url)

        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }

            guard let data = data else {
                completion(.failure(.emptyData))
                return
            }

            do {
                let decodedCats = try JSONDecoder().decode([CatData].self, from: data)
                completion(.success(decodedCats))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }.resume()
    }

    private func createRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: APIConfig.apiKeyHeaderField)
        return request
    }
}
