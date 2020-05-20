//
//  BalanseInfoTableViewCell.swift
//  FamilyBalance
//
//  Created by Anastasia Reyngardt on 20.05.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import UIKit

final class IncomeAndCostsCell: UITableViewCell, ReusableView {
    
    @IBOutlet weak var incomeToCostsRatioView: UIProgressView!
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
     
     override func layoutSubviews() {

     }
    
    private func setIncomeToCostsRatioViewUI() {
        incomeToCostsRatioView.progress = 0.5
        incomeToCostsRatioView.progressTintColor = #colorLiteral(red: 0.1411764706, green: 0.6196078431, blue: 0.262745098, alpha: 1)
        incomeToCostsRatioView.trackTintColor = #colorLiteral(red: 0.7215686275, green: 0.1137254902, blue: 0.07450980392, alpha: 1)
        incomeToCostsRatioView.transform = incomeToCostsRatioView.transform.scaledBy(x: 1, y: 3)
        incomeToCostsRatioView.layer.cornerRadius = AppSizes.litleViewCornerRadius
        incomeToCostsRatioView.clipsToBounds = true
    }
    
}
