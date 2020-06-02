
import UIKit
import RxSwift
import RxCocoa


final class FiltersCoordinator: BaseCoordirator {
    
    //MARK: - Private properties
    private var navController: UINavigationController
    private var filtersNavController: UINavigationController
    
    private let startFilter: PeriodFilter
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Init
    init(navController: UINavigationController, startFilter: PeriodFilter) {
        self.navController = navController
        self.startFilter = startFilter
        
         self.filtersNavController = UINavigationController()
    }
    
    
    //MARK: - Open metods
    override func start() {
        let filtersVC = UIStoryboard.instantiateFiltersVC()
        let viewModel = FiltersViewModel(startFilter: startFilter)
        filtersVC.viewModel = viewModel
        navController.present(filtersNavController, animated: true, completion: nil)
        filtersNavController.pushViewController(filtersVC, animated: false)
        
        observeViewModel(viewModel)
    }
    
    
    //MARK: - Private metods
    private func observeViewModel(_ viewModel: FiltersViewModelObservable) {
        
        viewModel.isSetFilter
            .bind { [weak self] filter in
                let listener: FiltersListener? = self?.findHandler()
                listener?.setFilter(filter)
        }
        .disposed(by: self.disposeBag)
        
        viewModel.isClosed
            .bind { [weak self] _ in
                self?.dismiss()
        }
        .disposed(by: self.disposeBag)
    }
    
    private func dismiss() {
        filtersNavController.dismiss(animated: true, completion: nil)
        parentCoordinator?.didFinish(coordinator: self)
    }
}
