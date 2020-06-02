
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
        let operationsNavController = createHistoryNavController()
        let addOperationNavController = createAddOperationNavController()
        
        tabbarVC.viewControllers = [costsNavController,
                                    addOperationNavController,
                                    operationsNavController]
        
        showCostModule(navController: costsNavController)
        showOperationsModule(navController: operationsNavController)
        showAddOperationModule(navController: addOperationNavController)
        
    }
    
    //MARK: - Create costs module
    private func createCostsNavController() -> UINavigationController {
        let costsNavController = UINavigationController()
        let itemImage = UIImage(named: "cost")?
            .scaleTo(CGSize(width: 30,
                            height: 30))
        costsNavController.tabBarItem = UITabBarItem(title: "Расходы",
                                                     image: itemImage,
                                                     tag: 0)
        return costsNavController
    }
    
    private func createHistoryNavController() -> UINavigationController {
        let operationsNavController = UINavigationController()
        let itemImage = UIImage(named: "list")?
        .scaleTo(CGSize(width: 30,
                        height: 30))
        operationsNavController.tabBarItem = UITabBarItem(title: "Операции",
                                                          image: itemImage,
                                                          tag: 2)
        return operationsNavController
    }
    
    private func createAddOperationNavController() -> UINavigationController {
        let addOperationNavController = UINavigationController()
        let itemImage = UIImage(named: "add")?
            .scaleTo(CGSize(width: 50,
                            height: 50))
        addOperationNavController.tabBarItem = UITabBarItem(title: nil,
                                                            image: itemImage,
                                                            tag: 1)
        return addOperationNavController
    }
    
    private func showCostModule(navController: UINavigationController) {
        let costsCoordinator = CostsCoordinator(navController: navController, repo: repo)
        childCoordinators.append(costsCoordinator)
        costsCoordinator.start()
    }
    
    private func showOperationsModule(navController: UINavigationController) {
        let operationsCoordinator = OperationsCoordinator(navController: navController, repo: repo)
        childCoordinators.append(operationsCoordinator)
        operationsCoordinator.start()
    }
    
    private func showAddOperationModule(navController: UINavigationController) {
        let addOperationCoordinator = AddOperationCoordinator(navController: navController, repo: repo)
        childCoordinators.append(addOperationCoordinator)
        addOperationCoordinator.start()
    }
}
