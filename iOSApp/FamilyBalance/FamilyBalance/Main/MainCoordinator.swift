
import UIKit

final class MainCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    func start() {
        let tabbarVC = UIStoryboard.instantiateMainViewController()
        navController.setViewControllers([tabbarVC], animated: false)
        navController.navigationBar.isHidden = false
        
        for children in tabbarVC.children {
            print(children)
        }
        print(navController.viewControllers)
    }
    
    
}
