
import Foundation
import RxSwift
import CoreData

protocol Repository {
    //TODO: signIn будет в отдельном репозитории
    func signIn(_ loginModel: UserLoginModel) -> Single<String>
    
    func getOperations() -> Observable<[Operation]>
    func getDefaultAccount() -> Single<Account>
    func getDefaultCategory() -> Single<Category>
    func getCategories() -> Observable<[Category]>
    func getAccounts() -> Observable<[Account]>
    
    func saveOperation(_ operation: OperationModel) -> Single<Void>
}


final class OperationsRepository: NSObject, Repository {
    
    private let apiClient: FafilyBalanseApiClient
    private let localManager: OperationsCoreDataManager
    
    private var operations: Observable<[Operation]>
    private let _operations = BehaviorSubject<[Operation]>(value: [])
    
    
    override init() {
        self.operations = _operations
        self.apiClient = FafilyBalanseApiClient()
        self.localManager = OperationsCoreDataManager()
        
        if UIApplication.checkIfFirstLaunch() {
            localManager.setDefoltData()
        }
    }
    
    //MARK: - Repository open metods
    //получить список операций за период от стартовой даты
    func getOperations() -> Observable<[Operation]> {
        
        localManager.getOperationsFRC() { [unowned self] frc in
            
            if let operations = frc.fetchedObjects {
                self._operations.onNext(operations)
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
                    self?.localManager.getCategories { single.onNext($0) }
                return Disposables.create()
        }
    }
    
    //получить счета
    func getAccounts() -> Observable<[Account]> {
        return Observable
            .create { [weak self] single in
                self?.localManager.getAccounts { single.onNext($0) }
                
                return Disposables.create()
        }
    }
    
    //получить счета
    func getDefaultAccount() -> Single<Account> {
        return Single
            .create { [weak self] single in
                self?.localManager.getAccounts {
                    single(.success($0[0]))
                }
                return Disposables.create()
        }
    }
    
    //получить дефолтную категорию, для экранов где необходимо сразу добававить дефолтные данные
    func getDefaultCategory() -> Single<Category> {
        return Single
            .create { [weak self] single in
                self?.localManager.getCategories {
                    single(.success($0[0]))
                }
                return Disposables.create()
        }
    }
    
    //TODO: signIn будет в отдельном репозитории
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

