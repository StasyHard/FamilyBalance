
import UIKit

class CostsCoordinator: BaseCoordirator {
    
    private var navController: UINavigationController
    
    init(navController: UINavigationController) {
           self.navController = navController
       }
    
    override func start() {
        let costsVC = UIStoryboard.instantiateCostsVC()
        navController.pushViewController(costsVC, animated: false)
    }
    
    
}