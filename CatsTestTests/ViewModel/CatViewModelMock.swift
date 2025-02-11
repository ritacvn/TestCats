//
//  MockCatViewModel.swift
//  CatsTestTests
//
//  Created by Rita Vasconcelos on 11/02/25.
//

import Foundation

class CatViewModelMock: CatViewModelProtocol {
    @Published var catImages: [CatData] = [CatData.mock()]
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func fetchCatImages(options: CatFetchOptions.Parameters) {}
    func reloadCatImages() {}
    func loadInitialCats() {}
    func loadMoreCats(_ index: Int) {}
}

extension CatData {
    static func mock() -> CatData {
        return CatData(id: "1", url: "https://cats.com/200/300", breeds: [])
    }
}
