
import UIKit
import RxSwift
import RxCocoa


final class AccountListViewController: UIViewController {
    
    //MARK: - Open properties
    var viewModel: (AccountListViewModelObservable & AccountListViewActions)?
    
    
    //MARK: - Private properties
    private lazy var accountListView = view as? AccountListViewImplementation
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationUI()
        
        guard let viewModel = viewModel else { return }
        accountListView?.setActionsDelegate(delegate: viewModel)
        observeViewModel(viewModel)
        
        viewModel.viewDidLoad()
    }
    
    
    //MARK: - Private metods
    private func setNavigationUI() {
        title = "Выбрать счет"
    }
    
    private func observeViewModel(_ viewModel: AccountListViewModelObservable) {
        viewModel.accounts
            .bind { [weak self] in
                self?.accountListView?.showAccounts($0)
        }
        .disposed(by: self.disposeBag)
        
        viewModel.selectedAccount
            .bind { [weak self] in
                self?.accountListView?.setSelectedAccount($0)
        }
        .disposed(by: self.disposeBag)
    }
    
    
}
