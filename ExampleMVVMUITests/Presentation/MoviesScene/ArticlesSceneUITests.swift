//
//  ArticlesSceneUITests.swift
//  ArticlesSceneUITests
//
//  Created by Oleh Kudinov on 05.08.19.
//

import XCTest

class ArticlesSceneUITests: XCTestCase {

    override func setUp() {

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
    }

    // NOTE: for UI tests to work the keyboard of simulator must be on.
    // Keyboard shortcut COMMAND + SHIFT + K while simulator has focus
    func testOpenArticleDetails_whenTapOnFirstResultRow_thenStoryDetailsViewOpens() {
        
        let app = XCUIApplication()
        
        _ = app.waitForExistence(timeout: 5)
        
        // Tap on first result row
        _ = app.cells[String(format: NSLocalizedString("Result row %d", comment: ""), 1)].waitForExistence(timeout: 10)
        app.cells[String(format: NSLocalizedString("Result row %d", comment: ""), 1)].tap()
        
        // Make sure story details view with title Batman opens
        XCTAssertTrue(app.otherElements[NSLocalizedString("Story details view", comment: "")].waitForExistence(timeout: 5))
    }
}
