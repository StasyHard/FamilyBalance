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
    
    // MARK: - Init
    init(navController: UINavigationController, window: UIWindow) {
        self.navController = navController
        self.window = window
    }
    
    //MARK: - Open metods
    func start() {
        window.rootViewController = navController
        window.makeKeyAndVisible()
        //TODO: --------------- открытие экрана в зависимости от того, логин или логаут
        showSignIn()
    }
    
    // MARK: - Navigation
    // TODO: -----------------------------Перенести часть логики в дочерний координатор
    private func showMain() {
        let mainCoordinator = MainCoordinator(navController: navController)
        childCoordinators.append(mainCoordinator)
        childCoordinators.removeAll { $0 is SignInCoordinator }
    }
    
    private func showSignIn() {
        let signInCoordinator = SignInCoordinator(navController: navController)
        childCoordinators.append(signInCoordinator)
        signInCoordinator.start()
    }
}

extension AppCoordinator: SignInCoordinatorDelegate {
    func didAuthenticate() {
        showMain()
    }
    
    
}


