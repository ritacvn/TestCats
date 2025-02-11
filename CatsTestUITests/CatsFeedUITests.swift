//
//  CatsFeedUITests.swift
//  CatsTestUITests
//
//  Created by Rita Vasconcelos on 11/02/25.
//

import XCTest

final class CatsFeedUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testCatsFeedScreenLoadsSuccessfully() {
        let navigationTitle = app.staticTexts["🐱 Cats Gallery"]
        XCTAssertTrue(navigationTitle.waitForExistence(timeout: 5), "CatsFeed screen did not load correctly")
    }
    
    func testCatsAreLoadedAndDisplayed() {
        let firstCatCell = app.scrollViews.children(matching: .other).element(boundBy: 0)
        XCTAssertTrue(firstCatCell.waitForExistence(timeout: 5), "Cat items are not appearing in the list")
    }
    
    func testNavigationToCatDetailView() {
        let firstCatCell = app.scrollViews.children(matching: .other).element(boundBy: 0)
        XCTAssertTrue(firstCatCell.waitForExistence(timeout: 5), "First cat cell is not available")
        firstCatCell.tap()

        let detailViewButton = app.staticTexts["WikipediaButton"]
                
        XCTAssertTrue(detailViewButton.waitForExistence(timeout: 5), "Navigation to CatDetailView failed")
    }

}
