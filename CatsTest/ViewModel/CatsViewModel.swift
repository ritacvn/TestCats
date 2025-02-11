//
//  CatsViewModel.swift
//  CatsTest
//
//  Created by Rita Vasconcelos on 10/02/25.
//

import Foundation

class CatViewModel: ObservableObject {
    @Published var catImages: [CatData] = []
    private let catService: CatServiceProtocol

    init(catService: CatServiceProtocol = CatService()) {
        self.catService = catService
    }

    func fetchCatImages(
        limit: Int = 10,
        page: Int = 0,
        order: String = "RAND",
        hasBreeds: Int = 1,
        breedIDs: String? = nil,
        categoryIDs: String? = nil,
        subID: String? = nil
    ) {
        catService.fetchCatImages(
            limit: limit,
            page: page,
            order: order,
            hasBreeds: hasBreeds,
            breedIDs: breedIDs,
            categoryIDs: categoryIDs,
            subID: subID
        ) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let cats):
                    self?.catImages.append(contentsOf: cats)
                case .failure(let error):
                    print("Error loading cats: \(error.localizedDescription)")
                }
            }
        }
    }
}
