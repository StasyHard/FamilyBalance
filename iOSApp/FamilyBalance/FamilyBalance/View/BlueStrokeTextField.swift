//
//  BlueStrokeTextField.swift
//  FamilyBalance
//
//  Created by Anastasia Reyngardt on 05.05.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import UIKit

class BlueStrokeTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.blue.cgColor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.blue.cgColor
    }

    
}
