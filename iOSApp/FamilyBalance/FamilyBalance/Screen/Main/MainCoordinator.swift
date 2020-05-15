
import UIKit

final class MainCoordinator: BaseCoordirator {
    
    private let navController: UINavigationController
    private let repo: Repository
    
    init(navController: UINavigationController, repo: Repository) {
        self.navController = navController
        self.repo = repo
    }
    
    override func start() {
        let tabbarVC = UIStoryboard.instantiateMainVC()
        navController.setViewControllers([tabbarVC], animated: false)
        
        let costsNavController = createCostsNavController()
        let historyOperationsNavController = createHistoryNavController()
        
        tabbarVC.viewControllers = [costsNavController, historyOperationsNavController]
        
        showCostModule(navController: costsNavController)
        showHistoryOperationsModule(navController: historyOperationsNavController)
        
    }
    
    //MARK: - Create costs module
    private func createCostsNavController() -> UINavigationController {
        let costsNavController = UINavigationController()
        costsNavController.tabBarItem = UITabBarItem(title: "Расходы",
                                                     image: nil,
                                                     tag: 0)
        return costsNavController
    }
    
    private func createHistoryNavController() -> UINavigationController {
        let historyOperationsNavController = UINavigationController()
        historyOperationsNavController.tabBarItem = UITabBarItem(title: "Операции",
                                                                 image: nil,
                                                                 tag: 1)
        return historyOperationsNavController
    }
    
    private func showCostModule(navController: UINavigationController) {
        let costsCoordinator = CostsCoordinator(navController: navController)
        childCoordinators.append(costsCoordinator)
        costsCoordinator.start()
    }
    
    private func showHistoryOperationsModule(navController: UINavigationController) {
        let historyOperationsCoordinator = OperationsCoordinator(
            navController: navController
        )
        childCoordinators.append(historyOperationsCoordinator)
        historyOperationsCoordinator.start()
    }
    
    
}
