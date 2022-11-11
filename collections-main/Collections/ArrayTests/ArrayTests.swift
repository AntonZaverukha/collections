//
//  ArrayTests.swift
//  ArrayTests
//
//  Created by Антон Заверуха on 26.07.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import XCTest
@testable import Collections

class ArrayTests: XCTestCase, ArrayProcessDidCreateArrayDelegate, ArrayProcessDidNewActionDelegate, CreatedArrayDelegate {
    var passCreatedArray: [Int] {
        passedArray!
    }
    
    func didNewAction(array: [Int], withElapsedTime time: TimeInterval, mode: ArrayCellsActionsMode, action: ArrayCellsActions) {
        self.createdArray = array
        self.mode = mode
        self.action = action
        exp?.fulfill()
        exp = nil
    }
    
    func didCreateArray(array: [Int], withElapsedTime time: TimeInterval) {
        self.createdArray = array
        exp?.fulfill()
        exp = nil
    }
    
    var createdArray: [Int] = []
    var mode: ArrayCellsActionsMode?
    var action: ArrayCellsActions?
    var exp: XCTestExpectation?
    var arrayProcess: ArrayProcess!
    var passedArray: [Int]?
    
    override func setUpWithError() throws {
        arrayProcess = ArrayProcess()
        passedArray = Array(0...9999999)
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        passedArray = nil
        arrayProcess = nil
    }
    
    func testCreationOfArray() throws {
        arrayProcess.arrayProcessDidCreateArrayDelegate = self
        exp = expectation(description: "Array update")
        arrayProcess.createArray()
        waitForExpectations(timeout: 7)
        let result = try XCTUnwrap(createdArray)
        XCTAssert(result.count == 10_000_000)
    }
    
    func testInsertElementsAtTheBeginningOfArray() throws {
        arrayProcess.arrayProcessDidNewActionDelegate = self
        arrayProcess.createdArrayDelegate = self
        exp = expectation(description: "Array update")
        arrayProcess.insertElementsAtTheBeginning(mode: .atOnce, action: .insertElementsAtTheBeginning)
        waitForExpectations(timeout: 10)
        let resultSlice = Array(createdArray[0...999])
        let predictedResult = Array(1...1000)
        XCTAssertEqual(resultSlice, predictedResult)
    }
    
    func testInsertElementsAtTheBeginningOfArrayOneByOne() throws {
        arrayProcess.arrayProcessDidNewActionDelegate = self
        arrayProcess.createdArrayDelegate = self
        exp = expectation(description: "Array update")
        arrayProcess.insertElementsAtTheBeginning(mode: .oneByOne, action: .insertElementsAtTheBeginning)
        waitForExpectations(timeout: 10)
        let resultSlice = Array(createdArray[0...999])
        let predictedResult = Array(1...1000)
        XCTAssertEqual(resultSlice, predictedResult)
    }
    
    func testInsertElementsInTheMiddleOfArray() throws {
        arrayProcess.arrayProcessDidNewActionDelegate = self
        arrayProcess.createdArrayDelegate = self
        exp = expectation(description: "Array update")
        arrayProcess.insertElementsInTheMiddle(mode: .atOnce, action: .insertElementsInTheMiddle)
        waitForExpectations(timeout: 10)
        let resultSlice = Array(createdArray[5_000_000...5_000_999])
        let predictedResult = Array(1...1000)
        XCTAssertEqual(resultSlice, predictedResult)
    }
    
    func testInsertElementsInTheMiddleOfArrayOneByOne() throws {
        arrayProcess.arrayProcessDidNewActionDelegate = self
        arrayProcess.createdArrayDelegate = self
        exp = expectation(description: "Array update")
        arrayProcess.insertElementsInTheMiddle(mode: .oneByOne, action: .insertElementsInTheMiddle)
        waitForExpectations(timeout: 10)
        let resultSlice = Array(createdArray[5_000_000...5_000_999])
        let predictedResult = Array(1...1000)
        XCTAssertEqual(resultSlice, predictedResult)
    }
    
    func testInsertElementsAtTheEndOfArray() throws {
        arrayProcess.arrayProcessDidNewActionDelegate = self
        arrayProcess.createdArrayDelegate = self
        exp = expectation(description: "Array update")
        arrayProcess.insertElementsAtTheEnd(mode: .atOnce, action: .insertElementsAtTheEnd)
        waitForExpectations(timeout: 10)
        let resultSlice = Array(createdArray[10_000_000...10_000_999])
        let predictedResult = Array(1...1000)
        XCTAssertEqual(resultSlice, predictedResult)
    }
    
    func testInsertElementsAtTheEndOfArrayOneByOne() throws {
        arrayProcess.arrayProcessDidNewActionDelegate = self
        arrayProcess.createdArrayDelegate = self
        exp = expectation(description: "Array update")
        arrayProcess.insertElementsAtTheEnd(mode: .oneByOne, action: .insertElementsAtTheEnd)
        waitForExpectations(timeout: 10)
        let resultSlice = Array(createdArray[10_000_000...10_000_999])
        let predictedResult = Array(1...1000)
        XCTAssertEqual(resultSlice, predictedResult)
    }
    
    func testRemoveElementsAtTheBeginningOfArray() throws {
        arrayProcess.arrayProcessDidNewActionDelegate = self
        arrayProcess.createdArrayDelegate = self
        exp = expectation(description: "Array update")
        arrayProcess.removeElementsAtTheBeginning(mode: .atOnce, action: .removeElementsAtTheBeginning)
        waitForExpectations(timeout: 10)
        let resultSlice = Array(createdArray[0...999])
        let predictedResult = Array(1000...1999)
        XCTAssertEqual(resultSlice, predictedResult)
    }
    
    func testRemoveElementsAtTheBeginningOfArrayOneByOne() throws {
        arrayProcess.arrayProcessDidNewActionDelegate = self
        arrayProcess.createdArrayDelegate = self
        exp = expectation(description: "Array update")
        arrayProcess.removeElementsAtTheBeginning(mode: .oneByOne, action: .removeElementsAtTheBeginning)
        waitForExpectations(timeout: 10)
        let resultSlice = Array(createdArray[0...999])
        let predictedResult = Array(1000...1999)
        XCTAssertEqual(resultSlice, predictedResult)
    }
    
    func testRemoveElementsInTheMiddleOfArray() throws {
        arrayProcess.arrayProcessDidNewActionDelegate = self
        arrayProcess.createdArrayDelegate = self
        exp = expectation(description: "Array update")
        arrayProcess.removeElementsInTheMiddle(mode: .atOnce, action: .removeElementsInTheMiddle)
        waitForExpectations(timeout: 10)
        let resultSlice = Array(createdArray[4_999_999...5_000_000])
        let predictedResult = [4_999_999, 5_001_000]
        XCTAssertEqual(resultSlice, predictedResult)
    }
    
    func testRemoveElementsInTheMiddleOfArrayOneByOne() throws {
        arrayProcess.arrayProcessDidNewActionDelegate = self
        arrayProcess.createdArrayDelegate = self
        exp = expectation(description: "Array update")
        arrayProcess.removeElementsInTheMiddle(mode: .oneByOne, action: .removeElementsInTheMiddle)
        waitForExpectations(timeout: 10)
        let resultSlice = Array(createdArray[4_999_999...5_000_000])
        let predictedResult = [4_999_999, 5_001_000]
        XCTAssertEqual(resultSlice, predictedResult)
    }
    
    func testRemoveElementsAtTheEndOfArray() throws {
        arrayProcess.arrayProcessDidNewActionDelegate = self
        arrayProcess.createdArrayDelegate = self
        exp = expectation(description: "Array update")
        arrayProcess.removeElementsAtTheEnd(mode: .atOnce, action: .removeElementsAtTheEnd)
        waitForExpectations(timeout: 10)
        let resultSlice = Array(createdArray[9_990_000...9_998_999])
        let predictedResult = Array(9_990_000...9_998_999)
        XCTAssertEqual(resultSlice, predictedResult)
    }
    
    func testRemoveElementsAtTheEndOfArrayOneByOne() throws {
        arrayProcess.arrayProcessDidNewActionDelegate = self
        arrayProcess.createdArrayDelegate = self
        exp = expectation(description: "Array update")
        arrayProcess.removeElementsAtTheEnd(mode: .oneByOne, action: .removeElementsAtTheEnd)
        waitForExpectations(timeout: 10)
        let resultSlice = Array(createdArray[9_990_000...9_998_999])
        let predictedResult = Array(9_990_000...9_998_999)
        XCTAssertEqual(resultSlice, predictedResult)
    }
    
    func testCreationOfArrayPerformance() throws {
        measure {
            arrayProcess.createArray()
        }
    }
    
    func testInsertElementsAtTheBeginningOneByOnePerformance() throws {
        arrayProcess.createdArrayDelegate = self
        measure {
            arrayProcess.insertElementsAtTheBeginning(mode: .oneByOne, action: .insertElementsAtTheBeginning)
        }
    }
    
    func testInsertElementsAtTheBeginningPerformance() throws {
        arrayProcess.createdArrayDelegate = self
        measure {
            arrayProcess.insertElementsAtTheBeginning(mode: .atOnce, action: .insertElementsAtTheBeginning)
        }
    }
    
    func testInsertElementsInTheMiddlePerformance() throws {
        arrayProcess.createdArrayDelegate = self
        measure {
            arrayProcess.insertElementsInTheMiddle(mode: .atOnce, action: .insertElementsInTheMiddle)
        }
    }
    
    func testInsertElementsInTheMiddleOneByOnePerformance() throws {
        arrayProcess.createdArrayDelegate = self
        measure {
            arrayProcess.insertElementsInTheMiddle(mode: .oneByOne, action: .insertElementsInTheMiddle)
        }
    }
    
    func testInsertElementsAtTheEndPerformance() throws {
        arrayProcess.createdArrayDelegate = self
        measure {
            arrayProcess.insertElementsAtTheEnd(mode: .atOnce, action: .insertElementsAtTheEnd)
        }
    }
    
    func testInsertElementsAtTheEndOneByOnePerformance() throws {
        arrayProcess.createdArrayDelegate = self
        measure {
            arrayProcess.insertElementsAtTheEnd(mode: .oneByOne, action: .insertElementsAtTheEnd)
        }
    }
    
    func testRemoveElementsAtTheBeginningPerformance() throws {
        arrayProcess.createdArrayDelegate = self
        measure {
            arrayProcess.removeElementsAtTheBeginning(mode: .atOnce, action: .removeElementsAtTheBeginning)
        }
    }
    
    func testRemoveElementsAtTheBeginningOneByOnePerformance() throws {
        arrayProcess.createdArrayDelegate = self
        measure {
            arrayProcess.removeElementsAtTheBeginning(mode: .oneByOne, action: .removeElementsAtTheBeginning)
        }
    }
    
    func testRemoveElementsInTheMiddlePerformance() throws {
        arrayProcess.createdArrayDelegate = self
        measure {
            arrayProcess.removeElementsInTheMiddle(mode: .atOnce, action: .removeElementsInTheMiddle)
        }
    }
    
    func testRemoveElementsInTheMiddleOneByOnePerformance() throws {
        arrayProcess.createdArrayDelegate = self
        measure {
            arrayProcess.removeElementsInTheMiddle(mode: .oneByOne, action: .removeElementsInTheMiddle)
        }
    }
    
    func testRemoveElementsAtTheEndPerformance() throws {
        arrayProcess.createdArrayDelegate = self
        measure {
            arrayProcess.removeElementsAtTheEnd(mode: .atOnce, action: .removeElementsAtTheEnd)
        }
    }
    
    func testRemoveElementsAtTheEndOneByOnePerformance() throws {
        arrayProcess.createdArrayDelegate = self
        measure {
            arrayProcess.removeElementsAtTheEnd(mode: .oneByOne, action: .removeElementsAtTheEnd)
        }
    }
}
