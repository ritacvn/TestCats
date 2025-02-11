//
//  CatViewModelTests.swift
//  CatsTestTests
//
//  Created by Rita Vasconcelos on 11/02/25.
//

import XCTest

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
            XCTAssertFalse(self.viewModel.showError, "Alert should not be shown")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

    func testFetchCatImages_EmptyData_ShowsErrorAlert() {
        mockService.mockResult = .failure(.emptyData)

        let expectation = expectation(description: "Should display error alert for empty data")
        viewModel.fetchCatImages()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.errorMessage, "No cat images were found.", "Expected empty data error message")
            XCTAssertTrue(self.viewModel.showError, "Error alert should be shown")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

    func testFetchCatImages_NetworkError_ShowsErrorAlert() {
        mockService.mockResult = .failure(.networkError(NSError(domain: "NetworkError", code: -1009, userInfo: nil)))

        let expectation = expectation(description: "Should display error alert for network issue")
        viewModel.fetchCatImages()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.viewModel.showError, "Error alert should be shown")
            XCTAssertNotNil(self.viewModel.errorMessage, "Error message should be set")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }
}
