//
//  AppCoordinator.swift
//  FamilyBalance
//
//  Created by Anastasia Reyngardt on 07.05.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import UIKit

protocol Coordinator {
    func start()
}

final class AppCoordinator: Coordinator {
    // MARK: - Properties
    private let navController: UINavigationController
    private let window: UIWindow
    
    private var childCoordinators: [Coordinator] = []
    
    // MARK: - Initializer
    init(navController: UINavigationController, window: UIWindow) {
        self.navController = navController
        self.window = window
    }
    
    func start() {
        window.rootViewController = navController
        window.makeKeyAndVisible()
        showAuth()
    }
    
    // MARK: - Navigation
    
    // Перенести логику в дочерний координатор
    private func showMain() {
        let mainVC = UIStoryboard.instantiateMainViewController()
        //navController.setViewControllers([mainVC], animated: true)
        navController.viewControllers = [mainVC]
        childCoordinators.removeAll { $0 is SignInCoordinator }
    }
    
    private func showAuth() {
        let signInCoordinator = SignInCoordinator(navController: navController, delegate: self)
        childCoordinators.append(signInCoordinator)
        signInCoordinator.start()
    }
}

extension AppCoordinator: SignInCoordinatorDelegate {
    func didAuthenticate() {
        showMain()
    }
    
    
}


