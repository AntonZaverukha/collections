//
//  SetProcess.swift
//  Collections
//
//  Created by Антон Заверуха on 21.07.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import Foundation
import UIKit

struct SetProcess {
    func processTextFields(text: String?, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let characterSet = NSCharacterSet.letters
        if (string.isEmpty) {
            return true
        } else {
            if string.rangeOfCharacter(from: characterSet) == nil {
                return false
            } else {
                return true
            }
        }
    }
    
    func checkAllTheSameLetters(_ firstString: String, _ secondString: String) -> String {
        let firstOrderedSet = NSMutableOrderedSet(array: Array(firstString))
        let secondOrderedSet = NSMutableOrderedSet(array: Array(secondString))
        
        firstOrderedSet.intersect(secondOrderedSet)
        let resultStringArray = firstOrderedSet.array.map { String(describing: $0) }
        return resultStringArray.joined(separator: "")
    }
    
    func checkAllTheDifferentLetters(_ firstString: String, _ secondString: String) -> String {
        let firstOrderedSet = NSMutableOrderedSet(array: Array(firstString))
        let secondOrderedSet = NSMutableOrderedSet(array: Array(secondString))
        let thirdOrderedSet = NSMutableOrderedSet(array: Array(secondString))

        secondOrderedSet.minus(firstOrderedSet)
        firstOrderedSet.minus(thirdOrderedSet)
        firstOrderedSet.union(secondOrderedSet)
        let resultStringArray = firstOrderedSet.array.map { String(describing: $0) }
        return resultStringArray.joined(separator: "")
    }
    
    func checkAllTheUniqueLetters(_ firstString: String, _ secondString: String) -> String {
        let firstOrderedSet = NSMutableOrderedSet(array: Array(firstString))
        let secondOrderedSet = NSMutableOrderedSet(array: Array(secondString))
        
        firstOrderedSet.minus(secondOrderedSet)
        let resultStringArray = firstOrderedSet.array.map { String(describing: $0) }
        return resultStringArray.joined(separator: "")
    }
}
