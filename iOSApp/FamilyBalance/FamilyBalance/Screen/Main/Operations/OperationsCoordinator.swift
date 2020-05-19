
import UIKit
import RxSwift
import RxCocoa


final class OperationsCoordinator: BaseCoordirator {
    
    private var navController: UINavigationController
    
    private let disposeBag = DisposeBag()
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    override func start() {
        let operationsVC = UIStoryboard.instantiateOperationsVC()
        let viewModel = OperationsViewModel()
        operationsVC.viewModel = viewModel
        navController.setViewControllers([operationsVC], animated: false)
        
        observeViewModel(viewModel)
    }
    
    private func observeViewModel(_ viewModel: OperationsViewModelObservable) {
        
    }
    
}
