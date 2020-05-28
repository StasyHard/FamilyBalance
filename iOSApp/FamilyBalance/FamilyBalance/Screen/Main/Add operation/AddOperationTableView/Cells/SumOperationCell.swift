//
//  SummOperationCell.swift
//  FamilyBalance
//
//  Created by Anastasia Reyngardt on 27.05.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import UIKit

class SumOperationCell: UITableViewCell, ReusableView {

    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var summTextField: UITextField! {
        didSet {
            summTextField.delegate = self
        }
    }
    
}

extension SumOperationCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let inputText = textField.text ?? ""
        textField.text = "\(inputText) ₽"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.endEditing(true)
        return true
    }
}
