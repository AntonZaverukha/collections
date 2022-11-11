//
//  ArrayProcess.swift
//  Collections
//
//  Created by Антон Заверуха on 04.07.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import Foundation

class ArrayProcess {
    weak var arrayProcessDidCreateArrayDelegate: ArrayProcessDidCreateArrayDelegate?
    weak var arrayProcessDidNewActionDelegate: ArrayProcessDidNewActionDelegate?
    weak var createdArrayDelegate: CreatedArrayDelegate?
    
    func createArray() {
            let info = ProcessInfo.processInfo
            let begin = info.systemUptime
            let array = Array(0...9999999)
            let diff = info.systemUptime - begin
            let diffRounded = round(diff * 1000) / 1000.0
            self.arrayProcessDidCreateArrayDelegate?.didCreateArray(array: array, withElapsedTime: diffRounded)
    }
    
    func insertElementsAtTheBeginning(mode: ArrayCellsActionsMode, action: ArrayCellsActions) {
        guard var unwrappedCreatedArray = self.createdArrayDelegate?.passCreatedArray else {
            return
        }
            let info = ProcessInfo.processInfo
            let begin = info.systemUptime
            if mode == .atOnce {
                unwrappedCreatedArray.insert(contentsOf: 1...1000, at: 0)
            } else if mode == .oneByOne {
                for i in 0 ..< 1000 {
                    unwrappedCreatedArray.insert(i, at: 0)
                }
            }
            let diff = info.systemUptime - begin
            let diffRounded = round(diff * 1000) / 1000.0
            self.arrayProcessDidNewActionDelegate?.didNewAction(array: unwrappedCreatedArray, withElapsedTime: diffRounded, mode: mode, action: action)
    }
    
    func insertElementsInTheMiddle(mode: ArrayCellsActionsMode, action: ArrayCellsActions) {
        guard var unwrappedCreatedArray = self.createdArrayDelegate?.passCreatedArray else {
            return
        }
            let info = ProcessInfo.processInfo
            let begin = info.systemUptime
            if mode == .atOnce {
                unwrappedCreatedArray.insert(contentsOf: 1...1000, at: unwrappedCreatedArray.count / 2)
            } else if mode == .oneByOne {
                for i in 0 ..< 1000 {
                    unwrappedCreatedArray.insert(i, at: unwrappedCreatedArray.count / 2)
                }
            }
            let diff = info.systemUptime - begin
            let diffRounded = round(diff * 1000) / 1000.0
            self.arrayProcessDidNewActionDelegate?.didNewAction(array: unwrappedCreatedArray, withElapsedTime: diffRounded, mode: mode, action: action)
    }
    
    func insertElementsAtTheEnd(mode: ArrayCellsActionsMode, action: ArrayCellsActions) {
        guard var unwrappedCreatedArray = self.createdArrayDelegate?.passCreatedArray else {
            return
        }
            let info = ProcessInfo.processInfo
            let begin = info.systemUptime
            if mode == .atOnce {
                unwrappedCreatedArray.append(contentsOf: 1...1000)
            } else if mode == .oneByOne {
                for i in 0 ..< 1000 {
                    unwrappedCreatedArray.append(i)
                }
            }
            let diff = info.systemUptime - begin
            let diffRounded = round(diff * 1000) / 1000.0
            self.arrayProcessDidNewActionDelegate?.didNewAction(array: unwrappedCreatedArray, withElapsedTime: diffRounded, mode: mode, action: action)
    }
    
    func removeElementsAtTheBeginning(mode: ArrayCellsActionsMode, action: ArrayCellsActions) {
        guard var unwrappedCreatedArray = self.createdArrayDelegate?.passCreatedArray else {
            return
        }
            let info = ProcessInfo.processInfo
            let begin = info.systemUptime
            if mode == .atOnce {
                unwrappedCreatedArray.removeSubrange(0 ..< 1000)
            } else if mode == .oneByOne {
                for _ in 0 ..< 1000 {
                    unwrappedCreatedArray.remove(at: 0)
                }
            }
            let diff = info.systemUptime - begin
            let diffRounded = round(diff * 1000) / 1000.0
            self.arrayProcessDidNewActionDelegate?.didNewAction(array: unwrappedCreatedArray, withElapsedTime: diffRounded, mode: mode, action: action)
    }
    
    func removeElementsInTheMiddle(mode: ArrayCellsActionsMode, action: ArrayCellsActions) {
        guard var unwrappedCreatedArray = self.createdArrayDelegate?.passCreatedArray else {
            return
        }
            let info = ProcessInfo.processInfo
            let begin = info.systemUptime
            if mode == .atOnce {
                unwrappedCreatedArray.removeSubrange(unwrappedCreatedArray.count / 2 ..< unwrappedCreatedArray.count / 2 + 1000)
            } else if mode == .oneByOne {
                for _ in 0 ..< 1000 {
                    unwrappedCreatedArray.remove(at: unwrappedCreatedArray.count / 2)
                }
            }
            let diff = info.systemUptime - begin
            let diffRounded = round(diff * 1000) / 1000.0
            self.arrayProcessDidNewActionDelegate?.didNewAction(array: unwrappedCreatedArray, withElapsedTime: diffRounded, mode: mode, action: action)
    }
    
    func removeElementsAtTheEnd(mode: ArrayCellsActionsMode, action: ArrayCellsActions) {
        guard var unwrappedCreatedArray = self.createdArrayDelegate?.passCreatedArray else {
            return
        }
            let info = ProcessInfo.processInfo
            let begin = info.systemUptime
            if mode == .atOnce {
                unwrappedCreatedArray.removeSubrange(unwrappedCreatedArray.count - 1000 ..< unwrappedCreatedArray.count)
            } else if mode == .oneByOne {
                for _ in 0 ..< 1000 {
                    unwrappedCreatedArray.removeLast()
                }
            }
            let diff = info.systemUptime - begin
            let diffRounded = round(diff * 1000) / 1000.0
            self.arrayProcessDidNewActionDelegate?.didNewAction(array: unwrappedCreatedArray, withElapsedTime: diffRounded, mode: mode, action: action)
        }
}
