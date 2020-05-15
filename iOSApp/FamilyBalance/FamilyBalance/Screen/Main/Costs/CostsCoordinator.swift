
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
        
        observeViewModel(viewModel)
    }
    
    private func observeViewModel(_ viewModel: CostsViewModelActions) {
        viewModel.filter
            .bind {  [weak self] _ in
                self?.showFilterModule()
        }
    }
    
    private func showFilterModule() {
        
    }
           
}
