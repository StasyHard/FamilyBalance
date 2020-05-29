
import UIKit
import RxSwift
import RxCocoa


class AddOperationCoordinator: BaseCoordirator {
    
    //MARK: - Private properties
    private var navController: UINavigationController
    private let repo: Repository
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Init
    init(navController: UINavigationController, repo: Repository) {
           self.navController = navController
        self.repo = repo
       }
    
    override func start() {
        let addOperationVC = UIStoryboard.instantiateAddOperationsVC()
        let viewModel = AddOperationViewModel(repo: repo)
        addOperationVC.viewModel = viewModel
        navController.setViewControllers([addOperationVC], animated: false)
        
        observeViewModel(viewModel)
    }
    
    //MARK: - Private metods
    private func observeViewModel(_ viewModel: AddOperationViewModelObservable) {
        viewModel.categoryDidTapped
            .bind { _ in
                //show module.....
        }
           .disposed(by: self.disposeBag)
    }
}
