//
//  CustomProgressView.swift
//  FamilyBalance
//
//  Created by Anastasia Reyngardt on 20.05.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import UIKit

class CustomProgressView: UIProgressView {
    
    private let cornerRadius: CGFloat = 10.0

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let maskLayerPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskLayerPath.cgPath
        layer.mask = maskLayer
    }
    
    
    private func setupUI() {
        progressTintColor = #colorLiteral(red: 0.1411764706, green: 0.6196078431, blue: 0.262745098, alpha: 1)
        trackTintColor = #colorLiteral(red: 0.7215686275, green: 0.1137254902, blue: 0.07450980392, alpha: 1)
    }
    
}
