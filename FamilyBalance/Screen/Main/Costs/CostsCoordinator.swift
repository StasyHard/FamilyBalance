
import UIKit
import RxSwift
import RxCocoa


final class CostsCoordinator: BaseCoordirator {
    
    //MARK: - Private properties
    private var navController: UINavigationController
    private var repo: OperationsRepositoryImpl
    private var viewModel: CostsViewModel?
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Init
    init(navController: UINavigationController, repo: OperationsRepositoryImpl) {
        self.navController = navController
        self.repo = repo
    }
    
    
    //MARK: - Open metods
    override func start() {
        let costsVC = UIStoryboard.instantiateCostsVC()
        let viewModel = CostsViewModel(repo: repo)
        costsVC.viewModel = viewModel
        navController.setViewControllers([costsVC], animated: false)
        
        observeViewModel(viewModel)
        self.viewModel = viewModel
    }
    
    
    //MARK: - Private metods
    private func observeViewModel(_ viewModel: CostsViewModelObservable) {
        viewModel.filtersTapped
            .bind {  [weak self] startFilter in
                self?.showFilterModule(startFilter: startFilter)
        }
        .disposed(by: self.disposeBag)
    }
    
    private func showFilterModule(startFilter: PeriodFilter) {
        let filtersCoordinator = FiltersCoordinator(navController: navController, startFilter: startFilter)
        childCoordinators.append(filtersCoordinator)
        filtersCoordinator.parentCoordinator = self
        filtersCoordinator.start()
    }
}



extension CostsCoordinator: FiltersListener {
    func setFilter(_ filter: PeriodFilter) {
        viewModel?.wasSetFilter(filter: filter)
    }
}
