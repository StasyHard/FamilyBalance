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
  private func showMain() {
    let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarVC") as! UITabBarController
    navController.setViewControllers([mainVC], animated: true)
  }

  private func showAuth() {
    let signInVC = UIStoryboard(name: "SignIn", bundle: nil)
    .instantiateViewController(withIdentifier: "signInVC") as! SignInViewController
    signInVC.delegate = self
    navController.setViewControllers([signInVC], animated: true)
  }
}

// MARK: - MainViewControllerDelegate
extension AppCoordinator: AuthViewControllerDelegate {
  func didSignIn() {
    showMain()
  }
}
