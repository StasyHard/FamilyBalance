
import UIKit
import RxSwift
import RxCocoa


class AddOperationCoordinator: BaseCoordirator {
    
    //MARK: - Private properties
    private var navController: UINavigationController
    private var viewModel: AddOperationViewModel?
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
        self.viewModel = viewModel
    }
    
    //MARK: - Private metods
    private func observeViewModel(_ viewModel: AddOperationViewModelObservable) {
        viewModel.categoryDidTapped
            .bind { [weak self] category in
                self?.showCategoryListModule(selectedCategory: category)
        }
           .disposed(by: self.disposeBag)
        
        viewModel.accountDidTapped
            .bind { [weak self] account in
                self?.showAccountListModule(selectedAccount: account)
        }
        .disposed(by: self.disposeBag)
    }
    
    private func showCategoryListModule(selectedCategory: CategoryModel) {
        let categoryListCoordinator = CategoryListCoordinator(navController: navController,
                                                              repo: repo,
                                                              selectedCategory: selectedCategory)
           childCoordinators.append(categoryListCoordinator)
           categoryListCoordinator.parentCoordinator = self
           categoryListCoordinator.start()
       }
    
    private func showAccountListModule(selectedAccount: AccountModel) {
        let accountListCoordinator = AccountListCoordinator(navController: navController,
                                                            repo: repo,
                                                            selectedAccount: selectedAccount)
        childCoordinators.append(accountListCoordinator)
        accountListCoordinator.parentCoordinator = self
        accountListCoordinator.start()
    }
}



extension AddOperationCoordinator: CategoryListener {
    
    func setCategory(_ category: CategoryModel) {
        viewModel?.setNewDefaultCategory(category)
    }
}


extension AddOperationCoordinator: AccountListener {
    func setAccount(_ account: AccountModel) {
        viewModel?.setNewDefaultAccount(account)
    }
    
    
}
