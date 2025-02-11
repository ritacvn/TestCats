//
//  CatFetchOptions.swift
//  CatsTest
//
//  Created by Rita Vasconcelos on 11/02/25.
//

import Foundation

enum CatFetchOptions {
    enum Order: String {
        case ascending = "ASC"
        case descending = "DESC"
        case random = "RAND"
    }

    struct Parameters {
        let limit: Int
        let page: Int
        let order: Order
        let hasBreeds: Int
        let breedIDs: String?
        let categoryIDs: String?
        let subID: String?

        static let `default` = Parameters()

        /// ✅ Agora o init tem valores padrão para evitar o erro
        init(
            limit: Int = 10,
            page: Int = 0,
            order: Order = .random,
            hasBreeds: Int = 1,
            breedIDs: String? = nil,
            categoryIDs: String? = nil,
            subID: String? = nil
        ) {
            self.limit = limit
            self.page = page
            self.order = order
            self.hasBreeds = hasBreeds
            self.breedIDs = breedIDs
            self.categoryIDs = categoryIDs
            self.subID = subID
        }
    }

}
