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

    func fetchCatImages() {
        isLoading = true
        errorMessage = nil

        catService.fetchCatImages { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let cats):
                    self?.catImages = cats
                case .failure(let error):
                    self?.errorMessage = "Error loading cats: \(error.localizedDescription)"
                }
            }
        }
    }
}
