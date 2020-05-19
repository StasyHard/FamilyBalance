
import UIKit
import RxSwift
import RxCocoa


final class FiltersCoordinator: BaseCoordirator {
    
    //MARK: - Private properties
    private var navController: UINavigationController
    private var filtersNavController: UINavigationController?
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Init
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    
    //MARK: - Open metods
    override func start() {
        let filtersNavController = UINavigationController()
        self.filtersNavController = filtersNavController
        
        let filtersVC = UIStoryboard.instantiateFiltersVC()
        let viewModel = FiltersViewModel()
        filtersVC.viewModel = viewModel
        navController.present(filtersNavController, animated: true, completion: nil)
        filtersNavController.pushViewController(filtersVC, animated: false)
        
        observeViewModel(viewModel)
    }
    
    
    //MARK: - Private metods
    private func observeViewModel(_ viewModel: FiltersViewModelObservable) {
        viewModel.isClosed
            .bind { [weak self] _ in
                self?.dismiss()
        }
        .disposed(by: self.disposeBag)
    }
    
    private func dismiss() {
        filtersNavController?.dismiss(animated: true, completion: nil)
        parentCoordinator?.didFinish(coordinator: self)
    }
}
