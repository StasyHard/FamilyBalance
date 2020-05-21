
import UIKit
import RxSwift
import RxCocoa


final class CostsCoordinator: BaseCoordirator {
    
    //MARK: - Private properties
    private var repo: Repository
    private var navController: UINavigationController
    private var viewModel: CostsViewModel?
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Init
    init(navController: UINavigationController, repo: Repository) {
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
            .bind {  [weak self] _ in
                self?.showFilterModule()
        }
        .disposed(by: self.disposeBag)
    }
    
    private func showFilterModule() {
        let filtersCoordinator = FiltersCoordinator(navController: navController)
        childCoordinators.append(filtersCoordinator)
        filtersCoordinator.parentCoordinator = self
        filtersCoordinator.start()
    }
}



extension CostsCoordinator: FiltersListener {
    func setFilter(_ filter: Filters) {
        viewModel?.wasSetFilter(filter: filter)
    }
    
    
}
