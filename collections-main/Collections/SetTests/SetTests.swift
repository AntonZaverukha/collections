//  CollectionsTests.swift
//  CollectionsTests
//
//  Created by Антон Заверуха on 23.07.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import XCTest
@testable import Collections

class SetTests: XCTestCase {
    var setProcess: SetProcess!
    
    override func setUpWithError() throws {
        setProcess = SetProcess()
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        setProcess = nil
        try super.tearDownWithError()
    }
    
    func testCheckAllTheSameLetters() throws {
        let stringOne = "Qwerty"
        let stringSecond = "Qarz"
        let result = setProcess.checkAllTheSameLetters(stringOne, stringSecond)
        XCTAssertEqual(result, "Qr")
    }
    
    func testCheckAllTheSameLettersFalse() throws {
        let stringOne = "Qwerty"
        let stringSecond = "Qarz"
        let result = setProcess.checkAllTheSameLetters(stringOne, stringSecond)
        XCTAssertNotEqual(result, "az")
    }
    
    func testCheckAllTheDifferentLetters() throws {
        let stringOne = "Qwerty"
        let stringSecond = "Qarz"
        let result = setProcess.checkAllTheDifferentLetters(stringOne, stringSecond)
        XCTAssertEqual(result, "wetyaz")
    }
    
    func testCheckAllTheDifferentLettersFalse() throws {
        let stringOne = "Qwerty"
        let stringSecond = "Qarz"
        let result = setProcess.checkAllTheDifferentLetters(stringOne, stringSecond)
        XCTAssertNotEqual(result, "Qr")
    }
    
    func testCheckAllUniqueLetters() throws {
        let stringOne = "Qwerty"
        let stringSecond = "Qarz"
        let result = setProcess.checkAllTheUniqueLetters(stringOne, stringSecond)
        XCTAssertEqual(result, "wety")
    }
    
    func testCheckAllUniqueLettersFalse() throws {
        let stringOne = "Qwerty"
        let stringSecond = "Qarz"
        let result = setProcess.checkAllTheUniqueLetters(stringOne, stringSecond)
        XCTAssertNotEqual(result, "Qr")
    }
    
    func testCheckLettersInput() throws {
        let stringOne = "Qwerty"
        let nsString = stringOne as NSString
        let textRange = NSMakeRange(0, nsString.length)
        let result = setProcess.processTextFields(text: stringOne, shouldChangeCharactersIn: textRange, replacementString: stringOne)
        XCTAssertTrue(result)
    }
    
    func testCheckLettersInputFalse() throws {
        let stringOne = "1234567890/:;"
        let nsString = stringOne as NSString
        let textRange = NSMakeRange(0, nsString.length)
        let result = setProcess.processTextFields(text: stringOne, shouldChangeCharactersIn: textRange, replacementString: stringOne)
        XCTAssertFalse(result)
    }
    
    func testCheckAllTheSameLettersPerformance() throws {
        measure {
            setProcess.checkAllTheSameLetters("Qwerty", "Qazr")
        }
    }
    
    func testCheckAllTheUniqueLettersPerformance() throws {
        measure {
            setProcess.checkAllTheUniqueLetters("Qwerty", "Qazr")
        }
    }
    
    func testCheckAllTheDifferentLettersPerformance() throws {
        measure {
            setProcess.checkAllTheDifferentLetters("Qwerty", "Qazr")
        }
    }
}



