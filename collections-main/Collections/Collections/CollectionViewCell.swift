//
//  CollectionViewCell.swift
//  Collections
//
//  Created by Антон Заверуха on 30.06.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    weak var collectionViewCellNewArrayDelegate: CollectionViewCellNewArrayDelegate?
    weak var collectionViewCellNewActionDelegate: CollectionViewCellNewActionDelegate?
    var cellModel: CollectionViewCellModel! {
        didSet {
            if let unwrappedActionTime = cellModel.actionTime {
                timeLabel.isHidden = false
                timeLabel.text = unwrappedActionTime
                arrayButton.isHidden = true
            } else {
                if cellModel.isActionPerformed {
                    activityIndicator.isHidden = false
                    activityIndicator.startAnimating()
                } else {
                    activityIndicator.isHidden = true
                    activityIndicator.stopAnimating()
                }
                arrayButton.isHidden = false
                arrayButton.titleLabel?.numberOfLines = 0
                arrayButton.isEnabled = self.cellModel.isButtonVisible
                arrayButton.setTitle(self.cellModel.buttonTitle, for: .normal)
                timeLabel.isHidden = true
            }
        }
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var arrayButton: UIButton!
    
    @IBAction func arrayButtonAction(_ sender: Any) {
        self.arrayButton.isHidden = true
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        if cellModel.action == .createArray {
            self.collectionViewCellNewArrayDelegate?.cellDidRequestNewArray(cell: self)
        } else if cellModel.action == .insertElementsAtTheBeginning {
            self.collectionViewCellNewActionDelegate?.cellDidRequestNewAction(mode: cellModel.mode, action: cellModel.action)
        } else if cellModel.action == .insertElementsInTheMiddle {
            self.collectionViewCellNewActionDelegate?.cellDidRequestNewAction(mode: cellModel.mode, action: cellModel.action)
        } else if cellModel.action == .insertElementsAtTheEnd {
            self.collectionViewCellNewActionDelegate?.cellDidRequestNewAction(mode: cellModel.mode, action: cellModel.action)
        } else if cellModel.action == .removeElementsAtTheBeginning {
            self.collectionViewCellNewActionDelegate?.cellDidRequestNewAction(mode: cellModel.mode, action: cellModel.action)
        } else if cellModel.action == .removeElementsInTheMiddle {
            self.collectionViewCellNewActionDelegate?.cellDidRequestNewAction(mode: cellModel.mode, action: cellModel.action)
        } else if cellModel.action == .removeElementsAtTheEnd {
            self.collectionViewCellNewActionDelegate?.cellDidRequestNewAction(mode: cellModel.mode, action: cellModel.action)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
}
