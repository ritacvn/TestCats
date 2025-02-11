//
//  CatDetailViewTests.swift
//  CatsTestUITests
//
//  Created by Rita Vasconcelos on 11/02/25.
//

import XCTest

final class CatDetailViewUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        
        openCatDetailScreen()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    
    func openCatDetailScreen() {
        let firstCatCell = app.scrollViews.children(matching: .other).element(boundBy: 0)
        XCTAssertTrue(firstCatCell.waitForExistence(timeout: 5), "First cat cell not found")
        firstCatCell.tap()
    }
    
    func testCatDetailScreenLoads() {
        let detailView = app.scrollViews.firstMatch
        XCTAssertTrue(detailView.waitForExistence(timeout: 5), "The detail screen did not load")
    }
    
    func testCatImageIsDisplayed() {
        let catImage = app.images.firstMatch
        XCTAssertTrue(catImage.waitForExistence(timeout: 5), "Cat image is not displayed")
    }
    
    func testCatDetailsAreDisplayed() {
        let aboutText = app.staticTexts["About"]
        XCTAssertTrue(aboutText.waitForExistence(timeout: 5), "'About' section is missing")
        
        let lifeSpanText = app.staticTexts["LifeSpan"]
        XCTAssertTrue(lifeSpanText.waitForExistence(timeout: 5), "'Life span' label is missing")
        
        let weightText = app.staticTexts["Weight"]
        XCTAssertTrue(weightText.waitForExistence(timeout: 5), "'Weight' label is missing")
    }
    
    func testWikipediaButtonExistsAndCanBeTapped() {
        let wikipediaButton = app/*@START_MENU_TOKEN@*/.staticTexts["WikipediaButton"]/*[[".buttons[\"🔗 Learn more on wikipedia\"]",".staticTexts[\"🔗 Learn more on wikipedia\"]",".staticTexts[\"WikipediaButton\"]",".buttons[\"WikipediaButton-WikipediaButton\"]"],[[[-1,2],[-1,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(wikipediaButton.waitForExistence(timeout: 5), "Wikipedia button is missing")
        
        wikipediaButton.tap()
    }
}
