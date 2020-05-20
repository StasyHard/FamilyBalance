//
//  CategoryCostTableViewCell.swift
//  FamilyBalance
//
//  Created by Anastasia Reyngardt on 18.05.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import UIKit

class CostCell: UITableViewCell, ReusableView {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    
    
        //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
        //MARK: - Private metods
    private func setupUI() {
        backgroundColor = AppColors.backgroundColor
    }
    
    override func layoutSubviews() {
        colorView.layer.cornerRadius = 7.0
        colorView.clipsToBounds = true
    }
    
}
