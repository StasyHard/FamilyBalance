//
//  AppCoordinator.swift
//  FamilyBalance
//
//  Created by Anastasia Reyngardt on 07.05.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

extension Coordinator {
    func didFinish(coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            self.childCoordinators.remove(at: index)
        }
    }
}

final class AppCoordinator: Coordinator {
    // MARK: - Properties
    private let window: UIWindow
    private let navController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    // MARK: - Init
    init(navController: UINavigationController, window: UIWindow) {
        self.navController = navController
        self.window = window
    }
    
    //MARK: - Open metods
    func start() {
        window.rootViewController = navController
        window.makeKeyAndVisible()
        //TODO: --------------- в зависимости от наличия токена открывается экран
        showSignIn()
    }
    
    // MARK: - Navigation
    private func showMain() {
        let mainCoordinator = MainCoordinator(navController: navController)
        childCoordinators.append(mainCoordinator)
        //mainCoordinator.parentCoordinator = self
        mainCoordinator.start()
    }
    
    private func showSignIn() {
        let signInCoordinator = SignInCoordinator(navController: navController)
        childCoordinators.append(signInCoordinator)
        signInCoordinator.parentCoordinator = self
        signInCoordinator.start()
    }
}


