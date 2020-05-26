
import UIKit
import RxSwift
import RxCocoa


final class OperationsCoordinator: BaseCoordirator {
    
    //MARK: - Private properties
    private var navController: UINavigationController
    
    private let repo: Repository
    
    private let disposeBag = DisposeBag()
    
    init(navController: UINavigationController, repo: Repository) {
        self.navController = navController
        self.repo = repo
    }
    
    override func start() {
        let operationsVC = UIStoryboard.instantiateOperationsVC()
        let viewModel = OperationsViewModel(repo: repo)
        operationsVC.viewModel = viewModel
        navController.setViewControllers([operationsVC], animated: false)
        
        observeViewModel(viewModel)
    }
    
    private func observeViewModel(_ viewModel: OperationsViewModelObservable) {
        
    }
    
}
