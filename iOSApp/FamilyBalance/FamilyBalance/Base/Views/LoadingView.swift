//
//  LoadingView.swift
//  FamilyBalance
//
//  Created by Anastasia Reyngardt on 07.05.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    //MARK: - IBOutlet
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Private properties
    private weak var containerView: UIView?
    
    private let contentViewWidth: CGFloat = 105.0
    private let contentViewHeight: CGFloat = 150.0
    
    //MARK: - Init
    init(inView view: UIView) {
        super.init(frame: view.bounds)
        self.containerView = view
        
        commonInit()
        setupFrame()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        setupViews()
    }
    
    //MARK: - Open metods
    func startLoading() {
        activityIndicator.startAnimating()
    }
    
    //MARK: - Private metods
    private func commonInit() {
        Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)
    }
    
    private func setupViews() {
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(contentView)
    }
    
    private func setupFrame() {
        guard let containerView = containerView
            else { return }
        self.frame  = CGRect(x: 0, y: 0, width: contentViewWidth, height: contentViewHeight)
        self.center = containerView.center
        containerView.addSubview(self)
    }
}
