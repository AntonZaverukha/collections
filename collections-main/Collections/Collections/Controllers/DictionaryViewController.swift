//
//  DictionaryViewController.swift
//  Collections
//
//  Created by Антон Заверуха on 15.07.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import UIKit

protocol DictionaryCellNewActionDelegate: AnyObject {
    func didRequestNewAction(mode: CellsMode, action: CellsActions, cell: DictionaryCollectionViewCell)
}

protocol DictionaryProcessDidCreateArrayDelegate: AnyObject {
    func didCreateArray(array: [ArrayContacts])
}

protocol DictionaryProcessDidCreateDictionaryDelegate: AnyObject {
    func didCreateDictionary(dictionary: [String: String])
}

protocol DictionaryCreatedArrayDelegate: AnyObject {
    var passCreatedArray: [ArrayContacts] { get }
}

protocol CreatedDictionaryDelegate: AnyObject {
    var passCreatedDictionary: [String: String] { get }
}

protocol DictionaryProcessDidArrayAction: AnyObject {
    func didArrayAction(arrayActionResult: ArrayContacts, withElapsedTime time: Double)
}

protocol DictionaryProcessDidDictionaryAction: AnyObject {
    func didDictionaryAction(dictionaryActionResult: String, withElapsedTime time: Double)
}

class DictionaryViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var arrayHeaderLabel: UILabel!
    @IBOutlet weak var dictionaryHeaderLabel: UILabel!
    var dictionaryProcess = DictionaryProcess()
    var setUpCellsArray = DictionaryCellsFactory.setUpCells()
    var collectionCell = DictionaryCollectionViewCell()
    var createdArray: [ArrayContacts] = []
    var createdDictionary: [String: String] = [:]
    var passedNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dictionaryProcess.dictionaryCreatedArrayDelegate = self
        dictionaryProcess.createdDictionaryDelegate = self
        dictionaryProcess.dictionaryProcessDidCreateArrayDelegate = self
        dictionaryProcess.dictionaryProcessDidCreateDictionaryDelegate = self
        dictionaryProcess.dictionaryProcessDidArrayAction = self
        dictionaryProcess.dictionaryProcessDidDictionaryAction = self
        self.title = "Dictionary: \(passedNumber)"
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        DispatchQueue.global(qos: .default).async {
            self.dictionaryProcess.createArray()
            self.dictionaryProcess.createDictionary()
        }
    }
}

extension DictionaryViewController {
    func createLayout() -> UICollectionViewCompositionalLayout {
        let items = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 1)
        
        let verticalGroup = CompositionalLayout.createGroup(aligment: .vertical, width: .fractionalWidth(0.5), height: .fractionalHeight(0.8), item: items, count: 3)
        let horizontalGroup = CompositionalLayout.createGroup(aligment: .horizontal, width: .fractionalWidth(1), height: .fractionalHeight(0.5), items: [verticalGroup, verticalGroup])
        let mainGroup = CompositionalLayout.createGroup(aligment: .vertical, width: .fractionalWidth(1), height: .absolute(500), items: [horizontalGroup])
        
        let section = NSCollectionLayoutSection(group: mainGroup)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension DictionaryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return setUpCellsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dictionaryCell", for: indexPath as IndexPath) as! DictionaryCollectionViewCell
        collectionCell = cell
        collectionCell.dictionaryCellNewActionDelegate = self
        cell.cellModel = setUpCellsArray[indexPath.item]
        
        return cell
    }
}

extension DictionaryViewController: DictionaryCellNewActionDelegate {
    func didRequestNewAction(mode: CellsMode, action: CellsActions, cell: DictionaryCollectionViewCell) {
        collectionCell = cell
        if action == .findTheFirstContact {
            dictionaryProcess.findTheFirstContact(mode: mode, action: action)
        } else if action == .findTheLastContact {
            dictionaryProcess.findTheLastContact(mode: mode, action: action)
        } else if action == .searchNonExistingElement {
            dictionaryProcess.findNonExistingContact(mode: mode, action: action)
        }
    }
}

extension DictionaryViewController: DictionaryCreatedArrayDelegate {
    var passCreatedArray: [ArrayContacts] {
        createdArray
    }
}

extension DictionaryViewController: DictionaryProcessDidCreateArrayDelegate {
    func didCreateArray(array: [ArrayContacts]) {
        createdArray = array
    }
}

extension DictionaryViewController: DictionaryProcessDidCreateDictionaryDelegate {
    func didCreateDictionary(dictionary: [String : String]) {
        createdDictionary = dictionary
        DispatchQueue.main.async {
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            self.activityIndicator.stopAnimating()
            self.arrayHeaderLabel.isHidden = false
            self.dictionaryHeaderLabel.isHidden = false
            self.collectionView.collectionViewLayout = self.createLayout()
        }
    }
}

extension DictionaryViewController: DictionaryProcessDidArrayAction {
    func didArrayAction(arrayActionResult: ArrayContacts, withElapsedTime time: Double) {
        collectionCell.resultLabel.isHidden = false
        formatActionResult(actionResultString: arrayActionResult.phone, time: time)
    }
}

extension DictionaryViewController: CreatedDictionaryDelegate {
    var passCreatedDictionary: [String: String] {
        createdDictionary
    }
}

extension DictionaryViewController: DictionaryProcessDidDictionaryAction {
    func didDictionaryAction(dictionaryActionResult: String, withElapsedTime time: Double) {
        collectionCell.resultLabel.isHidden = false
        formatActionResult(actionResultString: dictionaryActionResult, time: time)
    }
}

extension DictionaryViewController {
    func formatActionResult(actionResultString: String, time: Double) {
        collectionCell.resultLabel.text = "Result: \(actionResultString) \n" + " Search time: \(time)"
    }
}
