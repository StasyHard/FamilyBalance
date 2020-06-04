
import Foundation
import RxSwift
import RxCocoa


protocol AccountListViewModelObservable: class {
    var selectedAccount: Observable<AccountModel> { get set }
    var accounts: Observable<[AccountModel]> { get set }
}


final class AccountListViewModel: AccountListViewModelObservable {
    
    //MARK: - AccountListViewModelObservable
    var selectedAccount: Observable<AccountModel>
    var accounts: Observable<[AccountModel]>
    
    
    //MARK: - Private properties
    private let _selectedAccount: BehaviorSubject<AccountModel>
    private var _accounts = PublishSubject<[AccountModel]>()
    
    private let repo: Repository
    
    private let disposeBag = DisposeBag()
    
    //MARK: - Init
    init(repo: Repository, selectedAccount: AccountModel) {
        self.repo = repo
        
        _selectedAccount = BehaviorSubject<AccountModel>(value: selectedAccount)
        self.selectedAccount = _selectedAccount
        self.accounts = _accounts
    }
}



extension AccountListViewModel: AccountListViewActions {
    
    func viewDidLoad() {
        repo.getAccounts()
            .subscribe(
                onNext: { [weak self] accounts in
                    self?._accounts.onNext(accounts)
            })
            .disposed(by: self.disposeBag)
    }
    
    func wasSelectedAccount(account: AccountModel) {
        _selectedAccount.onNext(account)
    }
    
    
    
}
