//
//  CategoryCostTableViewCell.swift
//  FamilyBalance
//
//  Created by Anastasia Reyngardt on 18.05.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import UIKit

class CategoryCostsTableViewCell: UITableViewCell, ReusableView {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    
    
    override func layoutSubviews() {
        colorView.layer.cornerRadius = 10.0
        colorView.clipsToBounds = true
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
