
import UIKit
import RxSwift
import RxCocoa


class AddOperationCoordinator: BaseCoordirator {
    
    //MARK: - Private properties
    private var navController: UINavigationController
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Init
       init(navController: UINavigationController) {
           self.navController = navController
       }
    
    override func start() {
        let addOperationVC = UIStoryboard.instantiateAddOperationsVC()
        let viewModel = AddOperationViewModel()
        addOperationVC.viewModel = viewModel
        navController.setViewControllers([addOperationVC], animated: false)
        
        observeViewModel(viewModel)
    }
    
    //MARK: - Private metods
    private func observeViewModel(_ viewModel: AddOperationViewModelObservable) {
        
    }
}
