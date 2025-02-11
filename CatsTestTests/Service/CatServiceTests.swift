//
//  CatServiceTests.swift
//  CatsTestTests
//
//  Created by Rita Vasconcelos on 11/02/25.
//

import XCTest
@testable import CatsTest

class CatServiceTests: XCTestCase {
    var service: CatService!
    var mockSession: URLSessionMock!

    override func setUp() {
        super.setUp()
        mockSession = URLSessionMock()
        service = CatService(apiKey: "test_api_key", session: mockSession)
    }

    override func tearDown() {
        service = nil
        mockSession = nil
        super.tearDown()
    }

    func testFetchCatImages_Success() {
        let jsonData = """
        [
            {
                "id": "1",
                "url": "https://placekitten.com/200/300",
                "breeds": []
            }
        ]
        """.data(using: .utf8)

        mockSession.mockData = jsonData

        let expectation = self.expectation(description: "API should return cat images")

        service.fetchCatImages { result in
            switch result {
            case .success(let cats):
                XCTAssertEqual(cats.count, 1, "It should return 1 cat")
                XCTAssertEqual(cats.first?.url, "https://placekitten.com/200/300", "Image URL does not match")
            case .failure:
                XCTFail("The request should succeed")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

    func testFetchCatImages_EmptyData() {
        mockSession.mockData = nil

        let expectation = self.expectation(description: "Empty response should return emptyData error")

        service.fetchCatImages { result in
            if case .failure(let error) = result {
                XCTAssertEqual(error, .emptyData, "It should return an empty data error")
            } else {
                XCTFail("The request should fail")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

    func testFetchCatImages_DecodingError() {
        let invalidJsonData = """
        { "invalid_json": true }
        """.data(using: .utf8)

        mockSession.mockData = invalidJsonData

        let expectation = self.expectation(description: "Decoding error should be thrown")

        service.fetchCatImages { result in
            if case .failure(let error) = result {
                if case .decodingError(_) = error {
                    XCTAssertTrue(true, "It should return a decoding error")
                } else {
                    XCTFail("Incorrect error returned")
                }
            } else {
                XCTFail("The request should fail")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

    func testFetchCatImages_NetworkError() {
        let mockNetworkError = NSError(domain: "NetworkError", code: -1009, userInfo: nil)
        mockSession.mockError = mockNetworkError

        let expectation = self.expectation(description: "Network error should be thrown")

        service.fetchCatImages { result in
            if case .failure(let error) = result {
                if case .networkError(let nsError) = error {
                    XCTAssertEqual((nsError as NSError).code, -1009, "Error code should be -1009")
                } else {
                    XCTFail("Incorrect error returned")
                }
            } else {
                XCTFail("The request should fail")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }
}
