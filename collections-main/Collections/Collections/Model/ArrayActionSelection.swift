//
//  ArrayActionSelection.swift
//  Collections
//
//  Created by Антон Заверуха on 17.07.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import Foundation

struct ArrayActionSelection {
    func actionSelection(_ mode: ArrayCellsActionsMode, _ action: ArrayCellsActions, _ arrayProcess: ArrayProcess) {
        if action == .insertElementsAtTheBeginning {
            arrayProcess.insertElementsAtTheBeginning(mode: mode, action: action)
        } else if action == .insertElementsInTheMiddle {
            arrayProcess.insertElementsInTheMiddle(mode: mode, action: action)
        } else if action == .insertElementsAtTheEnd {
            arrayProcess.insertElementsAtTheEnd(mode: mode, action: action)
        } else if action == .removeElementsAtTheBeginning {
            arrayProcess.removeElementsAtTheBeginning(mode: mode, action: action)
        } else if action == .removeElementsInTheMiddle {
            arrayProcess.removeElementsInTheMiddle(mode: mode, action: action)
        } else if action == .removeElementsAtTheEnd {
            arrayProcess.removeElementsAtTheEnd(mode: mode, action: action)
        }
    }
}
