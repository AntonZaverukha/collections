//
//  CollectionsUITests.swift
//  CollectionsUITests
//
//  Created by Антон Заверуха on 31.07.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import XCTest

class CollectionsUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testArrayScreen() throws {
        let app = XCUIApplication()
        app.launch()
        
        let myTable = app.tables.matching(identifier: "tableView")
        let cell = myTable.cells.element(matching: .cell, identifier: "cell0")
        cell.tap()
        
        for index in 0...12 {
            app.collectionViews.cells.element(boundBy:index).tap()
            wait(for: 10)
        }
        
        app.navigationBars.buttons["Collections"].tap()
    }
    
    func testSetScreen() throws {
        let app = XCUIApplication()
        app.launch()
        
        let myTable = app.tables.matching(identifier: "tableView")
        let firstTextField = app.textFields["firstTF"]
        let secondTextField = app.textFields["secondTF"]
        let matchingLettersButton = app.buttons["allMatchingButton"]
        let doNotMatchingLettersButton = app.buttons["doNotMatchingButton"]
        let uniqueLettersButton = app.buttons["uniqueCharactersButton"]
        let cell = myTable.cells.element(matching: .cell, identifier: "cell1")
        cell.tap()
        
        firstTextField.tap()
        firstTextField.typeText("Qwerty")
        secondTextField.tap()
        secondTextField.typeText("Qazr")
        matchingLettersButton.tap()
        doNotMatchingLettersButton.tap()
        uniqueLettersButton.tap()
        
        XCTAssertEqual(app.staticTexts["allMatchingLabel"].label, "Qr")
        XCTAssertEqual(app.staticTexts["doNotMatchingLabel"].label, "wetyaz")
        XCTAssertEqual(app.staticTexts["uniqueCharactersLabel"].label, "wety")
    }
    
    func testDictionaryScreen() {
        let app = XCUIApplication()
        app.launch()
        
        let myTable = app.tables.matching(identifier: "tableView")
        let cell = myTable.cells.element(matching: .cell, identifier: "cell2")
        cell.tap()
        wait(for: 18)
        
        for index in 0...5 {
            app.collectionViews.cells.element(boundBy:index).tap()
            wait(for: 5)
        }
    }
}

extension XCTestCase {
  func wait(for duration: TimeInterval) {
    let waitExpectation = expectation(description: "Waiting")

    let when = DispatchTime.now() + duration
    DispatchQueue.main.asyncAfter(deadline: when) {
      waitExpectation.fulfill()
    }

    waitForExpectations(timeout: duration + 0.5)
  }
}
