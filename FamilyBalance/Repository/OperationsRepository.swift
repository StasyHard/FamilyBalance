
import Foundation
import RxSwift
import CoreData

protocol Repository {
    //signIn будет в отдельном репозитории
    func signIn(_ loginModel: UserLoginModel) -> Single<String>
    func getOperations(byPeriod period: PeriodModel) -> Observable<[Operation]>
    func getDefaultAccount() -> Single<AccountModel>
    func getDefaultCategory() -> Single<Category>
    func getCategories() -> Observable<[Category]>
    func getAccounts() -> Observable<[AccountModel]>
    
    func saveOperation(_ operation: OperationModel) -> Single<Void>
}


final class OperationsRepository: NSObject, Repository {
    
    private let apiClient = FafilyBalanseApiClient()
    private let localManager = OperationsCoreDataManager()
    
    private var operations: Observable<[Operation]>
    private let _operations = BehaviorSubject<[Operation]>(value: [])
    
    
    override init() {
        self.operations = _operations
        
        let first = UIApplication.isFirstLaunch()
        if first {
            localManager.setDefoltData()
        }
    }
    
    //MARK: - Repository open metods
    //получить список операций за определенный период
    func getOperations(byPeriod period: PeriodModel) -> Observable<[Operation]> {
        
        localManager.getOperationsFRC() { [unowned self] frc in
            
            if let operations = frc.fetchedObjects {
                let result = operations.filter { $0.date >= period.startDate }
                self._operations.onNext(result)
            }
        }
        return self.operations
    }
    
    //получить дефолтный счет, для экранов где необходимо сразу добававить дефолтные данные
    func saveOperation(_ operation: OperationModel) -> Single<Void> {
        return Single
            .create { [weak self] single in
                
                self?.localManager.saveOperation(operation) { result in
                    switch result {
                    case .success():
                        single(.success(()))
                    case .failure(let error):
                        single(.error(error))
                    }
                }
                return Disposables.create()
        }
    }
    
    //получить категории расходов
    func getCategories() -> Observable<[Category]> {
        return Observable
            .create { [weak self] single in
                if let `self` = self {
                    self.localManager.getCategories { single.onNext($0) }
                }
                return Disposables.create()
        }
    }
    
    //получить счета
    func getAccounts() -> Observable<[AccountModel]> {
        return Observable
            .create { result in
                result.onNext([cash, card])
                
                return Disposables.create()
        }
    }
    
    //получить счета
    func getDefaultAccount() -> Single<AccountModel> {
        return Single
            .create { single in
                
                let account = card
                single(.success(account))
                
                return Disposables.create()
        }
    }
    
    //получить дефолтную категорию, для экранов где необходимо сразу добававить дефолтные данные
    func getDefaultCategory() -> Single<Category> {
        return Single
            .create { single in
                self.localManager.getCategories {
                    single(.success($0[0]))
                }
                return Disposables.create()
        }
    }
    
    //signIn будет в отдельном репозитории
    func signIn(_ loginModel: UserLoginModel) -> Single<String> {
        return Single
            .create { [weak self] single in
                
                self?.apiClient.signIn(user: loginModel) { response in
                    if let token = response {
                        single(.success(token))
                    } else {
                        let error = NSError()
                        single(.error(error))
                    }
                }
                return Disposables.create()
        }
    }
}

extension OperationsRepository: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
    }
}

//let default = UserDefaults.standard
//default.set(accessToken, forKey: "accessToken")
//default.synchronized()
////Now get like this and use guard so that it will prevent your crash if value is nil.
//guard let accessTokenValue = default.string(forKey: "accessToken") else {return}
//print(accessTokenValue)

