//
//  MainCoordinator.swift
//  FamilyBalance
//
//  Created by Anastasia Reyngardt on 07.05.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    private var navController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    func start() {
        let tabbarVC = UIStoryboard.instantiateMainViewController()
        navController.setViewControllers([tabbarVC], animated: false)
        navController.navigationBar.isHidden = true
    }
    
    
}
