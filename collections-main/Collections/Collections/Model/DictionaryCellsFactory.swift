//  DictionaryCellsFactory.swift
//  Collections
//
//  Created by Антон Заверуха on 15.07.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import Foundation
import UIKit

class DictionaryCellsFactory {
    init(){}
    
    static func setUpCells() -> [DictionaryCollectionViewCellModel] {
        return [
            DictionaryCollectionViewCellModel(buttonTitle: "Find the first contact", mode: .array, action: .findTheFirstContact, actionResult: nil),
            DictionaryCollectionViewCellModel(buttonTitle: "Find the last contact", mode: .array, action: .findTheLastContact, actionResult: nil),
            DictionaryCollectionViewCellModel(buttonTitle: "Search for non-existing element", mode: .array, action: .searchNonExistingElement, actionResult: nil),
            DictionaryCollectionViewCellModel(buttonTitle: "Find the first contact", mode: .dictionary, action: .findTheFirstContact, actionResult: nil),
            DictionaryCollectionViewCellModel(buttonTitle: "Find the last contact", mode: .dictionary, action: .findTheLastContact, actionResult: nil),
            DictionaryCollectionViewCellModel(buttonTitle: "Search for non-existing element", mode: .dictionary, action: .searchNonExistingElement, actionResult: nil)
        ]
    }
}
