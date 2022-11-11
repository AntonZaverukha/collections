//
//  ArrayCellsFactory.swift
//  Collections
//
//  Created by Антон Заверуха on 06.07.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import Foundation
import UIKit

class ArrayCellsFactory {
    static func setUpCellCreateArray() -> [CollectionViewCellModel] {
        return [
            CollectionViewCellModel(action: .createArray, mode: .atOnce, buttonTitle:"Create Int array with 10_000_000 elements", labelText: "", isButtonVisible: true, actionTime: nil, isActionPerformed: false),
        ]
    }
    
    static func setUpCells() -> [CollectionViewCellModel] {
        return [
            CollectionViewCellModel(action: .insertElementsAtTheBeginning, mode: .atOnce, buttonTitle:"insert at the beginning of an array 1000 elements at once", labelText: "Time of action: ", isButtonVisible: true, actionTime: nil, isActionPerformed: false),
            CollectionViewCellModel(action: .insertElementsInTheMiddle, mode: .atOnce, buttonTitle:"insert in the middle of an array 1000 elements at once", labelText: "Time of action: ", isButtonVisible: true, actionTime: nil, isActionPerformed: false),
            CollectionViewCellModel(action: .insertElementsAtTheEnd, mode: .atOnce, buttonTitle:"append to the end of an array 1000 elements at once", labelText: "Time of action: ", isButtonVisible: true, actionTime: nil, isActionPerformed: false),
            CollectionViewCellModel(action: .removeElementsAtTheBeginning, mode: .atOnce, buttonTitle:"remove at the beginning 1000 elements at once", labelText: "Time of action: ", isButtonVisible: true, actionTime: nil, isActionPerformed: false),
            CollectionViewCellModel(action: .removeElementsInTheMiddle, mode: .atOnce, buttonTitle:"remove in the middle 1000 elements at once;", labelText: "Time of action: ", isButtonVisible: true, actionTime: nil, isActionPerformed: false),
            CollectionViewCellModel(action: .removeElementsAtTheEnd, mode: .atOnce, buttonTitle:"remove at the end 1000 elements at once", labelText: "Time of action: ", isButtonVisible: true, actionTime: nil, isActionPerformed: false),
            
            CollectionViewCellModel(action: .insertElementsAtTheBeginning, mode: .oneByOne, buttonTitle:"insert at the beginning of an array 1000 elements one-by-one ", labelText: "Time of action: ", isButtonVisible: true, actionTime: nil, isActionPerformed: false),
            CollectionViewCellModel(action: .insertElementsInTheMiddle, mode: .oneByOne, buttonTitle:"insert in the middle of an array 1000 elements one-by-one ", labelText: "Time of action: ", isButtonVisible: true, actionTime: nil, isActionPerformed: false),
            CollectionViewCellModel(action: .insertElementsAtTheEnd, mode: .oneByOne, buttonTitle:"append to the end of an array 1000 elements one-by-one ", labelText: "Time of action: ", isButtonVisible: true, actionTime: nil, isActionPerformed: false),
            CollectionViewCellModel(action: .removeElementsAtTheBeginning, mode: .oneByOne, buttonTitle:"remove at the beginning 1000 elements one-by-one ", labelText: "Time of action: ", isButtonVisible: true, actionTime: nil, isActionPerformed: false),
            CollectionViewCellModel(action: .removeElementsInTheMiddle, mode: .oneByOne, buttonTitle:"remove in the middle 1000 elements one-by-one ", labelText: "Time of action: ", isButtonVisible: true, actionTime: nil, isActionPerformed: false),
            CollectionViewCellModel(action: .removeElementsAtTheEnd, mode: .oneByOne, buttonTitle:"remove at the end 1000 elements one-by-one ", labelText: "Time of action: ", isButtonVisible: true, actionTime: nil, isActionPerformed: false),
        ]
    }
}
