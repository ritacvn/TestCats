//
//  CatAPITests.swift
//  CatsTest
//
//  Created by Rita Vasconcelos on 10/02/25.
//

import XCTest
@testable import CatsTest

class CatAPITests: XCTestCase {
    
    func test_CatAPI_getCatImagesURL_DefaultValues() {
        let url = CatAPI.getCatImagesURL()
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.absoluteString.contains("limit=10"), true)
        XCTAssertEqual(url?.absoluteString.contains("page=0"), true)
        XCTAssertEqual(url?.absoluteString.contains("order=RAND"), true)
        XCTAssertEqual(url?.absoluteString.contains("has_breeds=1"), true)
    }
    
    func test_CatAPI_getCatImagesURL_WithParameters() {
        let url = CatAPI.getCatImagesURL(limit: 5, page: 2, order: "ASC", hasBreeds: 0, breedIDs: "beng,abys", categoryIDs: "1,5,14")
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.absoluteString.contains("limit=5"), true)
        XCTAssertEqual(url?.absoluteString.contains("page=2"), true)
        XCTAssertEqual(url?.absoluteString.contains("order=ASC"), true)
        XCTAssertEqual(url?.absoluteString.contains("has_breeds=0"), true)
        XCTAssertEqual(url?.absoluteString.contains("breed_ids=beng,abys"), true)
        XCTAssertEqual(url?.absoluteString.contains("category_ids=1,5,14"), true)
    }
}
