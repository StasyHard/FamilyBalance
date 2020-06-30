
import UIKit
import RxSwift
import RxCocoa


final class AccountListCoordinator: BaseCoordirator {
    
    //MARK: - Private properties
    private var navController: UINavigationController
    private var accountListNavController: UINavigationController
    
    private let repo: Repository
    private var selectedAccount: Account
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Init
    init(navController: UINavigationController, repo: Repository, selectedAccount: Account) {
        self.navController = navController
        self.repo = repo
        self.selectedAccount = selectedAccount
        
        self.accountListNavController = UINavigationController()
    }
    
    override func start() {
        let accountListVC = UIStoryboard.instantiateAccountListVC()
        let viewModel = AccountListViewModel(repo: repo, selectedAccount: selectedAccount)
        accountListVC.viewModel = viewModel
        navController.present(accountListNavController, animated: true, completion: nil)
        accountListNavController.pushViewController(accountListVC, animated: false)
        
        observeViewModel(viewModel)
    }
    
    
    //MARK: - Private metods
    private func observeViewModel(_ viewModel: AccountListViewModelObservable) {
        
        viewModel.selectedAccount
            .bind { [weak self] account in
                guard let `self` = self else { return }
                if account != self.selectedAccount {
                    self.dismiss()
                    let listener: AccountListener? = self.findHandler()
                    listener?.setAccount(account)
                }
        }
        .disposed(by: self.disposeBag)
    }
    
    private func dismiss() {
        self.accountListNavController.dismiss(animated: true, completion: nil)
        self.parentCoordinator?.didFinish(coordinator: self)
    }
}
