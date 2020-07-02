
import Foundation
import RxSwift
import CoreData

protocol OperationsRepositoryImpl {
    //TODO: signIn будет в отдельном репозитории
    //func signIn(_ loginModel: UserLoginModel) -> Single<String>
    
    func getOperations() -> Observable<[Operation]>
    func getDefaultAccount() -> Single<Account>
    func getDefaultCategory() -> Single<Category>
    func getCategories() -> Observable<[Category]>
    func getAccounts() -> Observable<[Account]>
    
    func saveOperation(_ operation: OperationModel) -> Single<Void>
}


final class OperationsRepository: NSObject, OperationsRepositoryImpl {
    
    //private let apiClient: FafilyBalanseApiClient
    private let localManager: OperationsCoreDataManagerImpl
    
    private var operations: Observable<[Operation]>
    private let _operations = BehaviorSubject<[Operation]>(value: [])
    
    
    override init() {
        self.operations = _operations
        //self.apiClient = FafilyBalanseApiClient()
        self.localManager = OperationsCoreDataManager()
        
        if UIApplication.checkIfFirstLaunch() {
            localManager.setDefoltData()
        }
    }
    
    //MARK: - Repository open metods
    //получить список операций
    func getOperations() -> Observable<[Operation]> {
        localManager.getOperations() { [unowned self] operations in
            self._operations.onNext(operations)
        }
        return self.operations
    }
    
    //Сохранить операцию
    func saveOperation(_ operation: OperationModel) -> Single<Void> {
        return Single
            .create { [unowned self] single in
                
                self.localManager.saveOperation(operation) { result in
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
            .create { [unowned self] single in
                self.localManager.getCategories { single.onNext($0) }
                return Disposables.create()
        }
    }
    
    //получить счета
    func getAccounts() -> Observable<[Account]> {
        return Observable
            .create { [unowned self] single in
                self.localManager.getAccounts { single.onNext($0) }
                
                return Disposables.create()
        }
    }
    
    //получить дефолтный счет, для экранов где необходимо сразу добававить дефолтные данные
    func getDefaultAccount() -> Single<Account> {
        return Single
            .create { [unowned self] single in
                self.localManager.getAccounts {
                    single(.success($0[0]))
                }
                return Disposables.create()
        }
    }
    
    //получить дефолтную категорию, для экранов где необходимо сразу добававить дефолтные данные
    func getDefaultCategory() -> Single<Category> {
        return Single
            .create { [unowned self] single in
                self.localManager.getCategories {
                    single(.success($0[0]))
                }
                return Disposables.create()
        }
    }
    
    //TODO: signIn будет в отдельном репозитории
//    func signIn(_ loginModel: UserLoginModel) -> Single<String> {
//        return Single
//            .create { [weak self] single in
//                
//                self?.apiClient.signIn(user: loginModel) { response in
//                    if let token = response {
//                        single(.success(token))
//                    } else {
//                        let error = NSError()
//                        single(.error(error))
//                    }
//                }
//                return Disposables.create()
//        }
//    }
}
