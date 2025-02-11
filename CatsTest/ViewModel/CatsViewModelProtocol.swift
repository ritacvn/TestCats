//
//  CatsViewModelProtocol.swift
//  CatsTest
//
//  Created by Rita Vasconcelos on 11/02/25.
//

import Foundation

protocol CatViewModelProtocol: ObservableObject {
    var catImages: [CatData] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }

    func fetchCatImages(options: CatFetchOptions.Parameters)
    func reloadCatImages()
    func loadInitialCats()
    func loadMoreCats(_ index: Int)
}
