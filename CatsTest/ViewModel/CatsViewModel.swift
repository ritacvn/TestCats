//
//  CatsViewModel.swift
//  CatsTest
//
//  Created by Rita Vasconcelos on 10/02/25.
//

import Foundation

class CatViewModel: ObservableObject {
    @Published var catImages: [CatImage] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let catService = CatService()
    private var page = 1
    private let limit = 10
    
    func fetchCatImages() {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        
        catService.fetchCatImages(limit: limit, page: page) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let cats):
                    self?.catImages.append(contentsOf: cats)
                    self?.page += 1
                case .failure(let error):
                    self?.errorMessage = "Error loading cats: \(error.localizedDescription)"
                }
            }
        }
    }
}
