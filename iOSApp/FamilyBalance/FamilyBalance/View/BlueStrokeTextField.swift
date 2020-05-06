//
//  BlueStrokeTextField.swift
//  FamilyBalance
//
//  Created by Anastasia Reyngardt on 05.05.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import UIKit

class BlueStrokeTextField: UITextField {
    
    private var error = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.AppColors.textFieldBorderColor.cgColor
    }
    
    func textChanged(){
        if error == true {
            layer.borderColor = UIColor.AppColors.textFieldBorderColor.cgColor
            error = false
        }
    }
    
    func setError() {
        error = true
        layer.borderColor = UIColor.AppColors.textFieldErrorBorderColor.cgColor
    }

    
}
