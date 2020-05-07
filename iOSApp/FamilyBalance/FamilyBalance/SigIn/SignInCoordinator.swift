//
//  SignInCoordinator.swift
//  FamilyBalance
//
//  Created by Anastasia Reyngardt on 07.05.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import UIKit

protocol SignInViewControllerDelegate: AnyObject {
    func didSignIn()
}
protocol SignInCoordinatorDelegate: AnyObject {
    func didAuthenticate()
}

final class SignInCoordinator: Coordinator {
    private let navController: UINavigationController
    weak var delegate: SignInCoordinatorDelegate?
    
    init(navController: UINavigationController, delegate: SignInCoordinatorDelegate) {
        self.navController = navController
        self.delegate = delegate
    }
    func start() {
        let signInVC = UIStoryboard.instantiateSignInViewController(delegate: self)
        let viewModel = SignInViewModel()
        signInVC.viewModel = viewModel
        signInVC.delegate = self
        //navController.setViewControllers([signInVC], animated: true)
        navController.viewControllers = [signInVC]
        navController.navigationBar.isHidden = true
    }
}

extension SignInCoordinator: SignInViewControllerDelegate {
    func didSignIn() {
        // Authenticate via API, etc...
        delegate?.didAuthenticate()
    }
}


