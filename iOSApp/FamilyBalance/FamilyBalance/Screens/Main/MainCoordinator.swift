
import UIKit

final class MainCoordinator: BaseCoordirator {
    
    var navController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    override func start() {
        let tabbarVC = UIStoryboard.instantiateMainViewController()
        
        let costsNavController = createCostsNavController()
        
        tabbarVC.viewControllers = [costsNavController]
        navController.setViewControllers([tabbarVC], animated: false)
        //tabbarVC.modalPresentationStyle = .fullScreen
        //navController.present(tabbarVC, animated: false, completion: nil)
        
        showCostModule(navController: costsNavController)
        
    }
    
    //MARK: - Create costs module
    private func createCostsNavController() -> UINavigationController {
        let costsNavController = UINavigationController()
         costsNavController.tabBarItem = UITabBarItem(title: "Расходы",
                                                      image: nil,
                                                      tag: 0)
        return costsNavController
    }
    
    private func showCostModule(navController: UINavigationController) {
        let costsCoordinator = CostsCoordinator(navController: navController)
        childCoordinators.append(costsCoordinator)
        costsCoordinator.start()
    }
    
    
}
