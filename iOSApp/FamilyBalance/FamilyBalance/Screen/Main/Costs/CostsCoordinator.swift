
import UIKit
import RxSwift
import RxCocoa


class CostsCoordinator: BaseCoordirator {
    
    //MARK: - Private properties
    private var navController: UINavigationController
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Init
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    
    //MARK: - Open metods
    override func start() {
        let costsVC = UIStoryboard.instantiateCostsVC()
        let viewModel = CostsViewModel()
        costsVC.viewModel = viewModel
        navController.setViewControllers([costsVC], animated: false)
        
        observeViewModel(viewModel)
    }
    
    
    //MARK: - Private metods
    private func observeViewModel(_ viewModel: CostsViewModelActions) {
        viewModel.filter
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
