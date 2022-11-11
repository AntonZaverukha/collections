//
//  ArrayViewController.swift
//  Collections
//
//  Created by Антон Заверуха on 30.06.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import UIKit

protocol CollectionViewCellNewArrayDelegate: AnyObject {
    func cellDidRequestNewArray(cell: CollectionViewCell)
}

protocol CollectionViewCellNewActionDelegate: AnyObject {
    func cellDidRequestNewAction(mode: ArrayCellsActionsMode, action: ArrayCellsActions)
}

protocol ArrayProcessDidCreateArrayDelegate: AnyObject {
    func didCreateArray(array: [Int], withElapsedTime time: TimeInterval)
}

protocol ArrayProcessDidNewActionDelegate: AnyObject {
    func didNewAction(array: [Int], withElapsedTime time: TimeInterval, mode: ArrayCellsActionsMode, action: ArrayCellsActions)
}

protocol CreatedArrayDelegate: AnyObject {
    var passCreatedArray: [Int] { get }
}

class ArrayViewController: UIViewController, CollectionViewCellNewArrayDelegate, CollectionViewCellNewActionDelegate, ArrayProcessDidNewActionDelegate, CreatedArrayDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    var arrayProcess = ArrayProcess()
    var arrayActionSelection = ArrayActionSelection()
    var collectionCell = CollectionViewCell()
    var cellsSetUpModels = ArrayCellsFactory.setUpCells()
    var cellSetUpMain = ArrayCellsFactory.setUpCellCreateArray()
    var createdArray: [Int] = []
    var arrayCreationTime: String?
    var arrayActionIsPerformed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.accessibilityIdentifier = "collectionView"
        arrayProcess.arrayProcessDidCreateArrayDelegate = self
        arrayProcess.arrayProcessDidNewActionDelegate = self
        arrayProcess.createdArrayDelegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = createLayout()
    }
}

extension ArrayViewController {
    func createLayout() -> UICollectionViewCompositionalLayout {
        let items = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 1)
        let mainItem = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .absolute(100), spacing: 1)
        
        let verticalGroup = CompositionalLayout.createGroup(aligment: .vertical, width: .fractionalWidth(0.5), height: .fractionalHeight(1.7), item: items, count: 6)
        let horizontalGroup = CompositionalLayout.createGroup(aligment: .horizontal, width: .fractionalWidth(1), height: .fractionalHeight(0.5), items: [verticalGroup, verticalGroup])
        let mainGroup = CompositionalLayout.createGroup(aligment: .vertical, width: .fractionalWidth(1), height: .absolute(500), items: [mainItem, horizontalGroup])
        
        let section = NSCollectionLayoutSection(group: mainGroup)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension ArrayViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath as IndexPath) as! CollectionViewCell
        cell.accessibilityIdentifier = "cell\(indexPath.row)"
        cell.cellModel = cellSetUpMain[indexPath.item]
        cell.collectionViewCellNewActionDelegate = self
        cell.collectionViewCellNewArrayDelegate = self
        cell.arrayButton.tag = indexPath.item
        cell.activityIndicator.tag = indexPath.item
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellSetUpMain.count
    }
}

extension ArrayViewController: ArrayProcessDidCreateArrayDelegate {
    var passCreatedArray: [Int] {
        createdArray
    }
    
    func didNewAction(array: [Int], withElapsedTime time: TimeInterval, mode: ArrayCellsActionsMode, action: ArrayCellsActions) {
        createdArray = array
        guard let modelIndex = cellsSetUpModels.firstIndex (where: { $0.mode == mode && $0.action == action })
            else { return }
        cellsSetUpModels[modelIndex].actionTime = stringFromTimeInterval(interval: time)
        for model in cellsSetUpModels {
            model.isButtonVisible = true
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func cellDidRequestNewAction(mode: ArrayCellsActionsMode, action: ArrayCellsActions) {
        for model in cellsSetUpModels {
            model.isButtonVisible = false
        }
        guard let modelIndex = cellsSetUpModels.firstIndex (where: { $0.mode == mode && $0.action == action })
            else { return }
        cellsSetUpModels[modelIndex].isActionPerformed = true
        collectionView.reloadData()
        DispatchQueue.global(qos: .default).async {
            self.arrayActionSelection.actionSelection(mode, action, self.arrayProcess)
        }
    }
    
    func didCreateArray(array: [Int], withElapsedTime time: TimeInterval) {
        createdArray = array
        collectionCell.cellModel.actionTime = stringFromTimeInterval(interval: time)
        cellSetUpMain.append(contentsOf: self.cellsSetUpModels)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func cellDidRequestNewArray(cell: CollectionViewCell) {
        collectionCell = cell
        DispatchQueue.global(qos: .default).async {
            self.arrayProcess.createArray()
        }
    }
}

extension ArrayViewController {
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        let ms = Int(interval.truncatingRemainder(dividingBy: 1) * 1000)
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        return "Action time: " + formatter.string(from: interval)! + ".\(ms)"
    }
}
