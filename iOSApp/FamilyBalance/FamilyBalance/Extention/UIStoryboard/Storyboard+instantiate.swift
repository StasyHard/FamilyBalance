
import UIKit


extension UIStoryboard {
    // MARK: - Storyboards init
    private static var main: UIStoryboard {
      return UIStoryboard(name: "Main", bundle: nil)
    }

    private static var signIn: UIStoryboard {
      return UIStoryboard(name: "SignIn", bundle: nil)
    }
    
    private static var costs: UIStoryboard {
        return UIStoryboard(name: "Costs", bundle: nil)
    }
    
    private static var signUp: UIStoryboard {
        return UIStoryboard(name: "SignUp", bundle: nil)
    }
    
    private static var historyOperations: UIStoryboard {
        return UIStoryboard(name: "Operations", bundle: nil)
    }
    
    private static var filters: UIStoryboard {
        return UIStoryboard(name: "Filters", bundle: nil)
    }
    
    private static var addOperation: UIStoryboard {
        return UIStoryboard(name: "AddOperation", bundle: nil)
    }
    
    
    // MARK: - View Controllers init
    static func instantiateMainVC() -> UITabBarController {
      let mainVC = main.instantiateViewController(
        withIdentifier: "tabBarVC") as! UITabBarController
      return mainVC
    }

    static func instantiateSignInVC() -> SignInViewController {
      let signInVC = signIn.instantiateViewController(
        withIdentifier: "signInVC") as! SignInViewController
      return signInVC
    }
    
    static func instantiateCostsVC() -> CostsViewController {
        let costsVC = costs.instantiateViewController(
            withIdentifier: "costsVC") as! CostsViewController
        return costsVC
    }
    
    static func instantiateSignUpVC() -> SignUpViewController {
        let signUpVC = signUp.instantiateViewController(
            withIdentifier: "signUpVC") as! SignUpViewController
        return signUpVC
    }
    
    static func instantiateOperationsVC() -> OperationsViewController {
        let historyVC = historyOperations.instantiateViewController(
            withIdentifier: "operationsVC") as! OperationsViewController
        return historyVC
    }
    
    static func instantiateFiltersVC() -> FiltersViewController {
        let filterVC = filters.instantiateViewController(
            withIdentifier: "filtersVC") as! FiltersViewController
        return filterVC
    }
    
    static func instantiateAddOperationsVC() -> AddOperationViewController {
        let addOperationVC = addOperation.instantiateViewController(
            withIdentifier: "addOperation") as! AddOperationViewController
        return addOperationVC
    }
    
}

