
import UIKit
import RxSwift
import RxCocoa


final class OperationsCoordinator: BaseCoordirator {
    
    //MARK: - Private properties
    private var navController: UINavigationController
    
    private let repo: Repository
    private var viewModel: OperationsViewModel?
    
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
        self.viewModel = viewModel
    }
    
    private func observeViewModel(_ viewModel: OperationsViewModelObservable) {
        
        viewModel.filtersTapped
            .bind {  [weak self] startFilter in
                    self?.showFilterModule(startFilter: startFilter)
            }
            .disposed(by: self.disposeBag)
    }
    
    private func showFilterModule(startFilter: Filters) {
        let filtersCoordinator = FiltersCoordinator(navController: navController, startFilter: startFilter)
        childCoordinators.append(filtersCoordinator)
        filtersCoordinator.parentCoordinator = self
        filtersCoordinator.start()
    }
}



extension OperationsCoordinator: FiltersListener {
    func setFilter(_ filter: Filters) {
        viewModel?.wasSetFilter(filter: filter)
    }
}
