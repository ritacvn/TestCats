//
//  CatsViewModel.swift
//  CatsTest
//
//  Created by Rita Vasconcelos on 10/02/25.
//

import Foundation

class CatViewModel: CatViewModelProtocol {
    @Published var catImages: [CatData] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let catService: CatServiceProtocol
    
    init(catService: CatServiceProtocol = CatService()) {
        self.catService = catService
    }
    
    func fetchCatImages(options: CatFetchOptions.Parameters = .default) {
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        
        catService.fetchCatImages(options: options) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let cats):
                    if options.page == 0 {
                        self?.catImages = cats
                    } else {
                        self?.catImages.append(contentsOf: cats)
                    }
                case .failure(let error):
                    self?.errorMessage = self?.handleError(error)
                }
            }
        }
    }
    
    func reloadCatImages() {
        fetchCatImages(options: .default)
    }
    
    private func handleError(_ error: CatServiceError) -> String {
        switch error {
        case .invalidURL:
            return "The API URL is invalid."
        case .emptyData:
            return "No cat images were found."
        case .decodingError:
            return "There was a problem processing the data."
        case .networkError(let networkError):
            return "Network error: \(networkError.localizedDescription)"
        }
    }
}

extension CatViewModel {
    func loadInitialCats() {
        if catImages.isEmpty { fetchCatImages() }
    }
    
    func loadMoreCats(_ index: Int) {
        let thresholdIndex = catImages.count - 3
        guard index >= thresholdIndex, !isLoading else { return }
        
        let nextPage = catImages.count / 10
        let options = CatFetchOptions.Parameters(limit: 10, page: nextPage, order: .random)
        
        fetchCatImages(options: options)
    }
}
