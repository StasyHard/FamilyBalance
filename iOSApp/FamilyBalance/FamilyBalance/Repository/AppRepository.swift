
import Foundation
import RxSwift

protocol Repository {
    //signIn будет в отдельном репозитории
    func signIn(_ loginModel: UserLoginModel) -> Single<String>
    func getOperations(byPeriod period: Period) -> Observable<[Operation]>
    func getDefaultAccount() -> Single<Account>
    func getDefaultCategory() -> Single<Category>
    
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
    
    func getDefaultAccount() -> Single<Account> {
        return Single
            .create { single in
                
                let account = Account(id: 1, title: "Карта")
                single(.success(account))
                
                return Disposables.create()
        }
    }
    
    func getDefaultCategory() -> Single<Category> {
        return Single
            .create { single in
                
                let category = Category(id: 1, title: "Продукты")
                single(.success(category))
                
                return Disposables.create()
        }
    }
    
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
