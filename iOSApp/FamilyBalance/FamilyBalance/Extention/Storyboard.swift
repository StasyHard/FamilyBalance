//
//  Storyboard.swift
//  FamilyBalance
//
//  Created by Anastasia Reyngardt on 07.05.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import UIKit

extension UIStoryboard {
    // MARK: - Storyboards
    private static var main: UIStoryboard {
      return UIStoryboard(name: "Main", bundle: nil)
    }

    private static var signIn: UIStoryboard {
      return UIStoryboard(name: "SignIn", bundle: nil)
    }
    
    // MARK: - View Controllers
    static func instantiateMainViewController() -> UITabBarController {
      let mainVC = main.instantiateViewController(withIdentifier: "tabBarVC") as! UITabBarController
      return mainVC
    }

    static func instantiateSignInViewController(delegate: SignInViewControllerDelegate) -> SignInViewController {
      let signInVC = signIn.instantiateViewController(withIdentifier: "signInVC") as! SignInViewController
      signInVC.delegate = delegate
      return signInVC
    }
}
