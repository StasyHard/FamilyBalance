
import Foundation
import RxSwift
import RxCocoa

enum AddOperationResponse {
    case sumIsNil
    case error
    case success
}

protocol AddOperationViewModelObservable: class {
    var defaultAccount: Observable<AccountModel> { get set }
    var defaultCatecory: Observable<CategoryModel> { get set }
    var accountDidTapped: Observable<AccountModel> { get set }
    var categoryDidTapped: Observable<CategoryModel> { get set }
    
    var addOperationResponse: Observable<AddOperationResponse> { get set }
}


final class AddOperationViewModel: AddOperationViewModelObservable {
    
    //MARK: - AddOperationViewModelObservable
    var defaultAccount: Observable<AccountModel>
    var defaultCatecory: Observable<CategoryModel>
    var accountDidTapped: Observable<AccountModel>
    var categoryDidTapped: Observable<CategoryModel>
    var addOperationResponse: Observable<AddOperationResponse>
    
    
    //MARK: - Private properties
    private let _defaultAccount = PublishSubject<AccountModel>()
    private let _defaultCatecory = PublishSubject<CategoryModel>()
    private let _categoryDidTapped = PublishSubject<CategoryModel>()
    private let _accountDidTapped = PublishSubject<AccountModel>()
    private let _addOperationResponse = PublishSubject<AddOperationResponse>()
    
    private let repo: Repository
    private var defСategory: CategoryModel? {
        didSet {
            _defaultCatecory.onNext(defСategory!)
        }
    }
    private var defAccount: AccountModel? {
        didSet {
            _defaultAccount.onNext(defAccount!)
        }
    }
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Init
    init(repo: Repository) {
        self.repo = repo
        defaultAccount = _defaultAccount
        defaultCatecory = _defaultCatecory
        accountDidTapped = _accountDidTapped
        categoryDidTapped = _categoryDidTapped
        addOperationResponse = _addOperationResponse
    }
    
    
    //MARK: - Open metods
    func setNewDefaultCategory(_ category: CategoryModel) {
        defСategory = category
    }
    
    func setNewDefaultAccount(_ account: AccountModel) {
        defAccount = account
    }
}



//MARK: - AddOperationViewActions
extension AddOperationViewModel: AddOperationViewActions {
    
    func viewDidLoad() {
        repo.getDefaultAccount()
            .subscribe(onSuccess: { [weak self] account in
                self?.defAccount = account
            })
            .disposed(by: self.disposeBag)
        
        repo.getDefaultCategory()
            .subscribe(onSuccess: { [weak self] category in
                self?.defСategory = category
            })
            .disposed(by: self.disposeBag)
    }
    
    func accountButtonTapped() {
        guard let defAccount = defAccount else { return }
        _accountDidTapped.onNext(defAccount)
    }
    
    func categoryButtonTapped() {
        guard let defСategory = defСategory else { return }
        _categoryDidTapped.onNext(defСategory)
    }
    
    func saveOperationButtonTapped(sum: Double?, account: AccountModel, category: CategoryModel?) {
        if sum == nil {
            _addOperationResponse.onNext(.sumIsNil)
        }
        else {
            var operation: OperationModel
            if let category = category {
                let cost = OperationModel(id: 2,
                                     sum: sum!,
                                     date: Date().currentDate,
                                     comment: nil,
                                     account: account,
                                     category: category)
                operation = cost
            }
            else {
                let income = OperationModel(id: 1,
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
