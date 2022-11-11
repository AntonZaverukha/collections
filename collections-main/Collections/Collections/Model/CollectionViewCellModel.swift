//
//  CollectionViewCellModel.swift
//  Collections
//
//  Created by Антон Заверуха on 05.07.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import Foundation
import UIKit

enum ArrayCellsActions {
    case insertElementsAtTheBeginning
    case insertElementsInTheMiddle
    case insertElementsAtTheEnd
    case removeElementsAtTheBeginning
    case removeElementsInTheMiddle
    case removeElementsAtTheEnd
    case createArray
}

enum ArrayCellsActionsMode {
    case oneByOne
    case atOnce
}

class CollectionViewCellModel {
    var buttonTitle: String
    var labelText: String?
    var action: ArrayCellsActions
    var mode: ArrayCellsActionsMode
    var isButtonVisible: Bool
    var actionTime: String?
    var isActionPerformed: Bool
    
    init(action: ArrayCellsActions, mode: ArrayCellsActionsMode, buttonTitle: String, labelText: String, isButtonVisible: Bool, actionTime: String?, isActionPerformed: Bool) {
        self.action = action
        self.mode = mode
        self.buttonTitle = buttonTitle
        self.labelText = labelText
        self.isButtonVisible = isButtonVisible
        self.actionTime = actionTime
        self.isActionPerformed = isActionPerformed
    }
}
