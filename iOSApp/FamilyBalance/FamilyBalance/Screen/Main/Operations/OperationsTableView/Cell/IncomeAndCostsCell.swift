//
//  BalanseInfoTableViewCell.swift
//  FamilyBalance
//
//  Created by Anastasia Reyngardt on 20.05.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import UIKit

final class IncomeAndCostsCell: UITableViewCell, ReusableView {
    
    @IBOutlet weak var incomeToCostsRatioView: CustomProgressView!
    @IBOutlet weak var incomeSumLabel: UILabel!
    @IBOutlet weak var costsSumLabel: UILabel!
    

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
     }
    
}
