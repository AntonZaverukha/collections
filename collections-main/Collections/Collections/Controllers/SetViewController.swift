//
//  SetViewController.swift
//  Collections
//
//  Created by Антон Заверуха on 10.07.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import UIKit


class SetViewController: UIViewController {
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var allMatchingButton: UIButton!
    @IBOutlet weak var allMatchingLabel: UILabel!
    @IBOutlet weak var doNotMatchingButton: UIButton!
    @IBOutlet weak var doNotMatchingLabel: UILabel!
    @IBOutlet weak var uniqueCharactersButton: UIButton!
    @IBOutlet weak var uniqueCharactersLabel: UILabel!
    var setProcess = SetProcess()
    
    @IBAction func allMatchingAction(_ sender: Any) {
        allMatchingLabel.isHidden = false
        allMatchingLabel.text = setProcess.checkAllTheSameLetters(firstTextField.text!, secondTextField.text!)
    }
    
    @IBAction func doNotMatchingAction(_ sender: Any) {
        doNotMatchingLabel.isHidden = false
        doNotMatchingLabel.text = setProcess.checkAllTheDifferentLetters(firstTextField.text!, secondTextField.text!)
    }
    
    @IBAction func uniqueCharactersAction(_ sender: Any) {
        uniqueCharactersLabel.isHidden = false
        uniqueCharactersLabel.text = setProcess.checkAllTheUniqueLetters(firstTextField.text!, secondTextField.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uniqueCharactersButton.titleLabel?.numberOfLines = 0
        firstTextField.delegate = self
        secondTextField.delegate = self
        firstTextField.accessibilityIdentifier = "firstTF"
        secondTextField.accessibilityIdentifier = "secondTF"
        allMatchingButton.accessibilityIdentifier = "allMatchingButton"
        doNotMatchingButton.accessibilityIdentifier = "doNotMatchingButton"
        uniqueCharactersButton.accessibilityIdentifier = "uniqueCharactersButton"
        allMatchingLabel.accessibilityIdentifier = "allMatchingLabel"
        doNotMatchingLabel.accessibilityIdentifier = "doNotMatchingLabel"
        uniqueCharactersLabel.accessibilityIdentifier = "uniqueCharactersLabel"
    }
}

extension SetViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == firstTextField {
            return setProcess.processTextFields(text: textField.text, shouldChangeCharactersIn: range, replacementString: string)
        }
        if textField == secondTextField {
            return setProcess.processTextFields(text: textField.text, shouldChangeCharactersIn: range, replacementString: string)
        }
        return true
    }
}
