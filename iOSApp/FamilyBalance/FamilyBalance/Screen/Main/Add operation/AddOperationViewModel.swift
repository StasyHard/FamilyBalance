
import Foundation
import RxSwift
import RxCocoa

enum AddOperationResponse {
    case sumIsNil
    case error
    case success
}

protocol AddOperationViewModelObservable: class {
    var defaultAccount: Observable<Account> { get set }
    var defaultCatecory: Observable<Category> { get set }
    var categoryDidTapped: Observable<Void> { get set }
    var addOperationResponse: Observable<AddOperationResponse> { get set }
}


final class AddOperationViewModel: AddOperationViewModelObservable {
    
    //MARK: - AddOperationViewModelObservable
    var defaultAccount: Observable<Account>
    var defaultCatecory: Observable<Category>
    var categoryDidTapped: Observable<Void>
    var addOperationResponse: Observable<AddOperationResponse>
    
    
    //MARK: - Private properties
    private let _defaultAccount = PublishSubject<Account>()
    private let _defaultCatecory = PublishSubject<Category>()
    private let _categoryDidTapped = PublishSubject<Void>()
    private let _addOperationResponse = PublishSubject<AddOperationResponse>()
    
    private let repo: Repository
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Init
    init(repo: Repository) {
        self.repo = repo
        defaultAccount = _defaultAccount
        defaultCatecory = _defaultCatecory
        categoryDidTapped = _categoryDidTapped
        addOperationResponse = _addOperationResponse
    }
}



//MARK: - AddOperationViewActions
extension AddOperationViewModel: AddOperationViewActions {
    
    func viewDidLoad() {
        repo.getDefaultAccount()
            .subscribe(onSuccess: { [weak self] account in
                self?._defaultAccount.onNext(account)
            })
            .disposed(by: self.disposeBag)
        
        repo.getDefaultCategory()
            .subscribe(onSuccess: { [weak self] category in
                self?._defaultCatecory.onNext(category)
            })
            .disposed(by: self.disposeBag)
    }
    
    func accountButtonTapped() {
        
    }
    
    func categoryButtonTapped() {
        _categoryDidTapped.onNext(())
    }
    
    func saveOperationButtonTapped(sum: Double?, account: Account, category: Category?) {
        if sum == nil {
            _addOperationResponse.onNext(.sumIsNil)
        }
        else {
            var operation: Operation
            if let category = category {
                let cost = Operation(id: 2,
                                     sum: sum!,
                                     date: Date().currentDate,
                                     comment: nil,
                                     account: account,
                                     category: category)
                operation = cost
            }
            else {
                let income = Operation(id: 1,
                                       sum: sum!,
                                       date: Date().currentDate,
                                       comment: nil,
                                       account: account,
                                       category: nil)
                operation = income
            }
            
            repo.addOperation(operation)
                .subscribe(
                    onSuccess: { [weak self] _ in
                        self?._addOperationResponse.onNext(.success)
                },
                    onError: { [weak self] _ in
                        self?._addOperationResponse.onNext(.error)
                })
            .disposed(by: self.disposeBag)
        }
}
}
