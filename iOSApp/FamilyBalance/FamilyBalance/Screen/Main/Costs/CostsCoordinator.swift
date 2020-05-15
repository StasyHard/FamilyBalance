
import UIKit

class CostsCoordinator: BaseCoordirator {
    
    private var navController: UINavigationController
    
    init(navController: UINavigationController) {
           self.navController = navController
       }
    
    override func start() {
        let costsVC = UIStoryboard.instantiateCostsVC()
        let viewModel = CostsViewModel()
        costsVC.viewModel = viewModel
        navController.setViewControllers([costsVC], animated: false)
        costsVC.title = "Расходы"
        
        observeViewModel(viewModel)
    }
    
    private func observeViewModel(_ viewModel: CostsViewModelObservable) {
        
    }
           
}
