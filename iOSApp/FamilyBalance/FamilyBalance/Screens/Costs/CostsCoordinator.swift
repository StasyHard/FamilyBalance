
import UIKit

class CostsCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    
    private var navController: UINavigationController
    
    init(navController: UINavigationController) {
           self.navController = navController
       }
    
    func start() {
        let costsVC = UIStoryboard.instantiateCostsViewController()
        navController.pushViewController(costsVC, animated: false)
    }
    
    
}
