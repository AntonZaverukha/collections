//
//  DictionaryCollectionViewCell.swift
//  Collections
//
//  Created by Антон Заверуха on 15.07.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import UIKit

class DictionaryCollectionViewCell: UICollectionViewCell {
    weak var dictionaryCellNewActionDelegate: DictionaryCellNewActionDelegate?
    var cellModel: DictionaryCollectionViewCellModel! {
        didSet {
            actionButton.titleLabel?.numberOfLines = 0
            actionButton.isEnabled = true
            resultLabel.isHidden = true
            actionButton.setTitle(self.cellModel.buttonTitle, for: .normal)
            resultLabel.text = cellModel.actionResult
        }
    }
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    @IBAction func actionButton(_ sender: Any) {
        self.actionButton.isHidden = true
        if cellModel.action == .findTheFirstContact {
            self.dictionaryCellNewActionDelegate?.didRequestNewAction(mode: cellModel.mode, action: cellModel.action, cell: self)
        } else if cellModel.action == .findTheLastContact {
            self.dictionaryCellNewActionDelegate?.didRequestNewAction(mode: cellModel.mode, action: cellModel.action, cell: self)
        } else if cellModel.action == .searchNonExistingElement {
            self.dictionaryCellNewActionDelegate?.didRequestNewAction(mode: cellModel.mode, action: cellModel.action, cell: self)
        }
    }
}

