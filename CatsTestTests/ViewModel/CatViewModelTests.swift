//
//  CatViewModelTests.swift
//  CatsTestTests
//
//  Created by Rita Vasconcelos on 11/02/25.
//

import XCTest
@testable import CatsTest

class CatViewModelTests: XCTestCase {
    var viewModel: CatViewModel!
    var mockService: CatServiceMock!

    override func setUp() {
        super.setUp()
        mockService = CatServiceMock()
        viewModel = CatViewModel(catService: mockService)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    func testFetchCatImages_Success() {
        let mockCats = [
            CatData(id: "1", url: "https://placekitten.com/200/300", breeds: []),
            CatData(id: "2", url: "https://placekitten.com/250/350", breeds: [])
        ]
        mockService.mockResult = .success(mockCats)

        let expectation = expectation(description: "Successfully fetches cat images")
        viewModel.fetchCatImages()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.catImages.count, 2, "Expected 2 cat images")
            XCTAssertFalse(self.viewModel.isLoading, "Loading state should be false")
            XCTAssertNil(self.viewModel.errorMessage, "Error message should be nil")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

    func testIsLoadingState() {
        mockService.mockResult = .success([])

        XCTAssertFalse(viewModel.isLoading, "Initial loading state should be false")

        viewModel.fetchCatImages()
        XCTAssertTrue(viewModel.isLoading, "isLoading should be true after calling fetchCatImages")
    }

    func testFetchCatImages_EmptyData() {
        mockService.mockResult = .failure(.emptyData)

        let expectation = expectation(description: "Should return empty data error")
        viewModel.fetchCatImages()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.errorMessage, "No cat images were found.", "Expected empty data error message")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

    func testLoadMoreCats() {
        let mockCats = (1...10).map { CatData(id: "\($0)", url: "https://placekitten.com/\($0*10)/\($0*10)", breeds: []) }
        viewModel.catImages = mockCats
        mockService.mockResult = .success(mockCats)

        let expectation = expectation(description: "Should load more cats")
        viewModel.loadMoreCats(9)  

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.catImages.count, 20, "Expected 20 cat images after loading more")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }
}
