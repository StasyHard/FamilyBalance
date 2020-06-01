
import Foundation
import RxSwift

protocol Repository {
    //signIn будет в отдельном репозитории
    func signIn(_ loginModel: UserLoginModel) -> Single<String>
    func getOperations(byPeriod period: Period) -> Observable<[Operation]>
    func getDefaultAccount() -> Single<Account>
    func getDefaultCategory() -> Single<Category>
    func getCategories() -> Observable<[Category]>
    func getAccounts() -> Observable<[Account]>
    
    func addOperation(_ operation: Operation) -> Single<Void>
}


final class AppRepository: Repository {
    
    private let apiClient = FafilyBalanseApiClient()
    private let localClient = CoreDataClient()
    
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
    func getOperations(byPeriod period: Period) -> Observable<[Operation]> {
        return Observable
            .create { [weak self] result in
                //проверяем есть ли в базе данные за период, если нет запрашиваем у сервера
                let operations = self?.localClient.getOperations(byPeriod: period)
                result.onNext(operations!)
                //result.onError()
                
                return Disposables.create()
        }
    }
    
    //получить категории расходов
    func getCategories() -> Observable<[Category]> {
        return Observable
            .create { result in
                result.onNext([categProduct, categCar, categTransp, categChocolad, categKvartira, categZdorovie, categTelephone, categRazvlechen])
                
                return Disposables.create()
        }
    }
    
    //получить счета
    func getAccounts() -> Observable<[Account]> {
        return Observable
            .create { result in
                result.onNext([cash, card])
                 
                return Disposables.create()
        }
    }
    
    //получить счета
    func getDefaultAccount() -> Single<Account> {
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
                
                let category = categProduct
                single(.success(category))
                
                return Disposables.create()
        }
    }
    
    //получить дефолтный счет, для экранов где необходимо сразу добававить дефолтные данные
    func addOperation(_ operation: Operation) -> Single<Void> {
        return Single
            .create { single in
                
                if self.localClient.addOperation(operation) {
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
