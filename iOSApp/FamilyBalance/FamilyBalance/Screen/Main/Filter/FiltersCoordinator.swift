
import UIKit
import RxSwift
import RxCocoa


class FiltersCoordinator: BaseCoordirator {
    
    private var navController: UINavigationController
    
    private let disposeBag = DisposeBag()
    
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    //MARK: - Open metods
    override func start() {
        let filtersVC = UIStoryboard.instantiateFiltersVC()
        navController.present(filtersVC, animated: true, completion: nil)
    }
    
    
    //MARK: - Private metods
    private func observeViewModel(_ viewModel: CostsViewModelActions) {
        
    }
}
