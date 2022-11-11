//
//  DictionaryCollectionViewCellModel.swift
//  Collections
//
//  Created by Антон Заверуха on 25.07.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import Foundation
import UIKit

enum CellsMode {
    case array
    case dictionary
}

enum CellsActions {
    case findTheFirstContact
    case findTheLastContact
    case searchNonExistingElement
}

class DictionaryCollectionViewCellModel {
    var buttonTitle: String
    var mode: CellsMode
    var action: CellsActions
    var actionResult: String?
    
    init(buttonTitle: String, mode: CellsMode, action: CellsActions, actionResult: String?) {
        self.buttonTitle = buttonTitle
        self.mode = mode
        self.action = action
        self.actionResult = actionResult
    }
    
}
