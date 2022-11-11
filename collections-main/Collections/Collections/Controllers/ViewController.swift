//
//  ViewController.swift
//  Collections
//
//  Created by Антон Заверуха on 30.06.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let collections = ["Array", "Set", "Dictionary"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.accessibilityIdentifier = "tableView"
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width - 32, height: 40))

        let label = UILabel(frame: CGRect(x: 16, y: 0, width: header.frame.size.width, height: header.frame.size.height))
        header.addSubview(label)

        label.text = "Collections"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)

        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collections.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if (indexPath.row == 1) {
            performSegue(withIdentifier: "goToSetStoryboard", sender: self)
        }
        if (indexPath.row == 2) {
            DispatchQueue.main.async {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Dictionary", bundle: nil)
                guard let destinationVC = storyBoard.instantiateViewController(withIdentifier: "DictionaryVC") as? DictionaryViewController else { return }
                destinationVC.passedNumber = self.randomNumber
                self.navigationController?.pushViewController(destinationVC, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.accessibilityIdentifier = "cell\(indexPath.row)"
        cell.accessoryType = .disclosureIndicator
        cell.collectionsLabel.text = collections[indexPath.row]
        return cell
    }
}

extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Collections"
        navigationItem.backBarButtonItem = backItem
        
        if segue.identifier == "goToArrayStoryboard",
            let arrayViewController = segue.destination as? ArrayViewController {
            arrayViewController.title = "Array: \(randomNumber)"
        }
        if segue.identifier == "goToSetStoryboard",
            let setViewController = segue.destination as? SetViewController {
            setViewController.title = "Set: \(randomNumber)"
        }
}
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        guard let senderCell = sender as? UITableViewCell else { return false }
        
        if identifier == "goToArrayStoryboard" && senderCell == cell {
            return true
        } else {
            return false
        }
    }

    var randomNumber: Int {
        Int.random(in: 1..<10000)
    }
}
