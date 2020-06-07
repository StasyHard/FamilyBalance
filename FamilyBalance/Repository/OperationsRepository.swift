
import Foundation
import RxSwift
import CoreData

protocol Repository {
    //signIn будет в отдельном репозитории
    func signIn(_ loginModel: UserLoginModel) -> Single<String>
    func getOperations(byPeriod period: PeriodModel) -> Observable<[OperationModel]>
    func getOperationsResult(byPeriod period: PeriodModel) -> Observable<[Operation]>
    func getDefaultAccount() -> Single<AccountModel>
    func getDefaultCategory() -> Single<CategoryModel>
    func getCategories() -> Observable<[CategoryModel]>
    func getAccounts() -> Observable<[AccountModel]>
    
    func addOperation(_ operation: OperationModel) -> Single<Void>
}


final class OperationsRepository: NSObject, Repository {
    
    private let apiClient = FafilyBalanseApiClient()
    private let localManager = CoreDataManager()
    
    private var operations: Observable<[Operation]>?
    
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
    
    //получить список операций за определенный период
    func getOperations(byPeriod period: PeriodModel) -> Observable<[OperationModel]> {
        return Observable
            .create { [weak self] result in
                let operations = self?.localManager.getOperations(byPeriod: period)
                //let resp = self?.localManager.getOperations(startDate: period.startDate, endDate: period.startDate)
                result.onNext(operations!)
                //result.onError()
                
                return Disposables.create()
        }
    }
    
    func getOperationsResult(byPeriod period: PeriodModel) -> Observable<[Operation]> {
        if operations == nil {
            operations = Observable
                .create { [weak self] result in
                    let operationsFRC = self?.localManager.getOperations(startDate: period.startDate, endDate: period.startDate)
                    print(operationsFRC)
                    operationsFRC?.delegate = self
                    
                    let operations = operationsFRC?.fetchedObjects
                    print(operations)
                    //result.onNext((operationsFRC?.fetchedObjects)!)
                    return Disposables.create()
            }
        }
        return operations!
    }
    
    //получить категории расходов
    func getCategories() -> Observable<[CategoryModel]> {
        return Observable
            .create { result in
                result.onNext([categProduct, categCar, categTransp, categChocolad, categKvartira, categZdorovie, categTelephone, categRazvlechen])
                
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
    func getDefaultCategory() -> Single<CategoryModel> {
        return Single
            .create { single in
                
                let category = categProduct
                single(.success(category))
                
                return Disposables.create()
        }
    }
    
    //получить дефолтный счет, для экранов где необходимо сразу добававить дефолтные данные
    func addOperation(_ operation: OperationModel) -> Single<Void> {
        return Single
            .create { single in
                
                if self.localManager.addOperation(operation) {
                    single(.success(()))
                }
                else {
                    single(.error(NSError()))
                }
                
            return Disposables.create()
        }
    }
}


//let default = UserDefaults.standard
//default.set(accessToken, forKey: "accessToken")
//default.synchronized()
////Now get like this and use guard so that it will prevent your crash if value is nil.
//guard let accessTokenValue = default.string(forKey: "accessToken") else {return}
//print(accessTokenValue)

extension OperationsRepository: NSFetchedResultsControllerDelegate {
 
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        //let result = controller.fetchedObjects as? [Operation] ?? []
        
    }
}
