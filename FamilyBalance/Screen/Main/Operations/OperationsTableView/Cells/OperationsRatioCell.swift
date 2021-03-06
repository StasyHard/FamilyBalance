//
//  BalanseInfoTableViewCell.swift
//  FamilyBalance
//
//  Created by Anastasia Reyngardt on 20.05.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import UIKit

final class OperationsRatioCell: UITableViewCell, ReusableView {
    
    @IBOutlet weak var ratioProgressView: CustomProgressView!
    @IBOutlet weak var incomeSumLabel: UILabel!
    @IBOutlet weak var costsSumLabel: UILabel!
    
}
