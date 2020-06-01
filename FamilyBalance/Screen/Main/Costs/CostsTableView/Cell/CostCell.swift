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
        colorView.layer.cornerRadius = 10
        colorView.clipsToBounds = true
    }
}



//extension CostCell {
//    func setstroke() {
//        let frame = CGRect(x: colorView.frame.origin.x + colorView.frame.width,
//            y: colorView.frame.origin.y,
//            width: self.frame.width - 50,
//            height: colorView.frame.height)
//        let view = UIView(frame: frame)
//        self.addSubview(view)
//        view.backgroundColor = .red
//    }
//}
