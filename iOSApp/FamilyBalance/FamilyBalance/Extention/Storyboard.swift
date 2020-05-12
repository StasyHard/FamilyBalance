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
    
    private static var costs: UIStoryboard {
        return UIStoryboard(name: "Costs", bundle: nil)
    }
    
    // MARK: - View Controllers
    static func instantiateMainViewController() -> UITabBarController {
      let mainVC = main.instantiateViewController(withIdentifier: "tabBarVC") as! UITabBarController
      return mainVC
    }

    static func instantiateSignInViewController() -> SignInViewController {
      let signInVC = signIn.instantiateViewController(withIdentifier: "signInVC") as! SignInViewController
      return signInVC
    }
    
    static func instantiateCostsViewController() -> CostsViewController {
        let costsVC = costs.instantiateViewController(withIdentifier: "costsVC") as! CostsViewController
        return costsVC
    }
}
