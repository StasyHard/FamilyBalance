
import UIKit
import RxSwift
import RxCocoa


class FiltersCoordinator: BaseCoordirator {
    
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
        navController.present(filtersNavController, animated: true, completion: nil)
        
        let filtersVC = UIStoryboard.instantiateFiltersVC()
        filtersNavController.pushViewController(filtersVC, animated: false)
    }
    
    
    //MARK: - Private metods
    private func observeViewModel(_ viewModel: CostsViewModelActions) {
        
    }
}
