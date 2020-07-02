
import Foundation
import RxSwift
import RxCocoa


protocol AccountListViewModelObservable: class {
    var selectedAccount: Observable<Account> { get set }
    var accounts: Observable<[Account]> { get set }
}


final class AccountListViewModel: AccountListViewModelObservable {
    
    //MARK: - AccountListViewModelObservable
    var selectedAccount: Observable<Account>
    var accounts: Observable<[Account]>
    
    
    //MARK: - Private properties
    private let _selectedAccount: BehaviorSubject<Account>
    private var _accounts = PublishSubject<[Account]>()
    
    private let repo: OperationsRepositoryImpl
    
    private let disposeBag = DisposeBag()
    
    //MARK: - Init
    init(repo: OperationsRepositoryImpl, selectedAccount: Account) {
        self.repo = repo
        
        _selectedAccount = BehaviorSubject<Account>(value: selectedAccount)
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
    
    func wasSelectedAccount(account: Account) {
        _selectedAccount.onNext(account)
    }
    
    
    
}
