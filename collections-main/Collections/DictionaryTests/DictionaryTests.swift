//
//  DictionaryTests.swift
//  DictionaryTests
//
//  Created by Антон Заверуха on 28.07.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import XCTest
@testable import Collections

class DictionaryTests: XCTestCase, DictionaryProcessDidCreateArrayDelegate, DictionaryProcessDidCreateDictionaryDelegate, DictionaryProcessDidArrayAction, DictionaryCreatedArrayDelegate, CreatedDictionaryDelegate, DictionaryProcessDidDictionaryAction {
    func didDictionaryAction(dictionaryActionResult: String, withElapsedTime time: Double) {
        self.dictionaryActionResult = dictionaryActionResult
        exp?.fulfill()
        exp = nil
    }
    
    var passCreatedDictionary: [String : String] {
        passedDictionary!
    }
    
    var passCreatedArray: [ArrayContacts] {
        passedArray!
    }
    
    func didArrayAction(arrayActionResult: ArrayContacts, withElapsedTime time: Double) {
        self.arrayActionResult = arrayActionResult
        exp?.fulfill()
        exp = nil
    }
    
    func didCreateDictionary(dictionary: [String : String]) {
        self.createdDictionary = dictionary
        exp?.fulfill()
        exp = nil
    }
    
    func didCreateArray(array: [ArrayContacts]) {
        self.createdArray = array
        exp?.fulfill()
        exp = nil
    }
    
    var arrayActionResult: ArrayContacts?
    var dictionaryActionResult: String?
    var createdArray: [ArrayContacts] = []
    var createdDictionary: [String: String] = [:]
    var passedArray: [ArrayContacts]?
    var passedDictionary: [String: String]?
    var exp: XCTestExpectation?
    var dictionaryProcess: DictionaryProcess!
    
    override func setUpWithError() throws {
        dictionaryProcess = DictionaryProcess()
        passedArray = createArray()
        passedDictionary = createDictionary()
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        passedArray = nil
        passedDictionary = nil
        dictionaryProcess = nil
    }
    
    func testCreatedArray() throws {
        dictionaryProcess.dictionaryProcessDidCreateArrayDelegate = self
        exp = expectation(description: "Array update")
        dictionaryProcess.createArray()
        waitForExpectations(timeout: 10)
        let result = try XCTUnwrap(createdArray)
        XCTAssert(result.count == 10_000_000)
    }
    
    func testCreatedDictionary() throws {
        dictionaryProcess.dictionaryProcessDidCreateDictionaryDelegate = self
        exp = expectation(description: "Dictionary update")
        dictionaryProcess.createDictionary()
        waitForExpectations(timeout: 15)
        let result = try XCTUnwrap(createdDictionary)
        XCTAssert(result.count == 10_000_000)
    }
    
    func testCheckTheFirstContact() throws {
        dictionaryProcess.dictionaryProcessDidCreateArrayDelegate = self
        dictionaryProcess.dictionaryProcessDidArrayAction = self
        dictionaryProcess.dictionaryCreatedArrayDelegate = self
        dictionaryProcess.dictionaryProcessDidCreateDictionaryDelegate = self
        dictionaryProcess.createdDictionaryDelegate = self
        dictionaryProcess.dictionaryProcessDidDictionaryAction = self
        
        exp = expectation(description: "Action")
        dictionaryProcess.findTheFirstContact(mode: .array, action: .findTheFirstContact)
        dictionaryProcess.findTheFirstContact(mode: .dictionary, action: .findTheFirstContact)
        waitForExpectations(timeout: 15)

        XCTAssert(arrayActionResult?.phone == "0")
        XCTAssert(dictionaryActionResult == "0")
    }
    
    func testCheckTheLastContact() throws {
        dictionaryProcess.dictionaryProcessDidCreateArrayDelegate = self
        dictionaryProcess.dictionaryProcessDidArrayAction = self
        dictionaryProcess.dictionaryCreatedArrayDelegate = self
        dictionaryProcess.dictionaryProcessDidCreateDictionaryDelegate = self
        dictionaryProcess.createdDictionaryDelegate = self
        dictionaryProcess.dictionaryProcessDidDictionaryAction = self
        
        exp = expectation(description: "Action")
        dictionaryProcess.findTheLastContact(mode: .array, action: .findTheFirstContact)
        dictionaryProcess.findTheLastContact(mode: .dictionary, action: .findTheFirstContact)
        waitForExpectations(timeout: 15)

        XCTAssert(arrayActionResult?.phone == "9999999")
        XCTAssert(dictionaryActionResult == "9999999")
    }
    
    func testCheckNonExistContact() throws {
        dictionaryProcess.dictionaryProcessDidCreateArrayDelegate = self
        dictionaryProcess.dictionaryProcessDidArrayAction = self
        dictionaryProcess.dictionaryCreatedArrayDelegate = self
        dictionaryProcess.dictionaryProcessDidCreateDictionaryDelegate = self
        dictionaryProcess.createdDictionaryDelegate = self
        dictionaryProcess.dictionaryProcessDidDictionaryAction = self
        
        exp = expectation(description: "Action")
        dictionaryProcess.findNonExistingContact(mode: .array, action: .findTheFirstContact)
        dictionaryProcess.findNonExistingContact(mode: .dictionary, action: .findTheFirstContact)
        waitForExpectations(timeout: 15)

        XCTAssert(arrayActionResult?.phone == "Non Exist")
        XCTAssert(dictionaryActionResult == "Non Exist")
    }
    
    func testCreationOfArrayPerformance() throws {
        measure {
            dictionaryProcess.createArray()
        }
    }
    
    func testCreationOfDictionaryPerformance() throws {
        measure {
            dictionaryProcess.createDictionary()
        }
    }
    
    func testFindingTheFirstContact() throws {
        dictionaryProcess.createdDictionaryDelegate = self
        dictionaryProcess.dictionaryCreatedArrayDelegate = self
        measure {
            dictionaryProcess.findTheFirstContact(mode: .array, action: .findTheFirstContact)
            dictionaryProcess.findTheFirstContact(mode: .dictionary, action: .findTheFirstContact)
        }
    }
    
    func testFindingTheLastContact() throws {
        dictionaryProcess.createdDictionaryDelegate = self
        dictionaryProcess.dictionaryCreatedArrayDelegate = self
        measure {
            dictionaryProcess.findTheLastContact(mode: .array, action: .findTheFirstContact)
            dictionaryProcess.findTheLastContact(mode: .dictionary, action: .findTheFirstContact)
        }
    }
    
    func testFindingNonExistingContact() throws {
        dictionaryProcess.createdDictionaryDelegate = self
        dictionaryProcess.dictionaryCreatedArrayDelegate = self
        measure {
            dictionaryProcess.findNonExistingContact(mode: .array, action: .searchNonExistingElement)
            dictionaryProcess.findNonExistingContact(mode: .dictionary, action: .searchNonExistingElement)
        }
    }
}

extension DictionaryTests {
    func createArray() -> [ArrayContacts] {
        var array: [ArrayContacts] = []
        
        for i in 0 ..< 10_000_000 {
            array.append(ArrayContacts(name: "Name\(i)", phone: String(i)))
        }
        return array
    }
    
    func createDictionary() -> [String: String] {
        var dictionary: [String: String] = [:]

            for i in 0 ..< 10_000_000 {
                dictionary.updateValue(String(i), forKey: "Name\(i)")
            }
        return dictionary
    }
}
