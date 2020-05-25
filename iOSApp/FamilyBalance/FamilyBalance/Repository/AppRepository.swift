
import Foundation
import RxSwift

protocol Repository {
    func signIn(_ loginModel: UserLoginModel) -> Single<String>
    func getOperations(filter: Filters) -> Observable<[Operation]>
}


final class AppRepository: Repository {
    
    private let apiClient = FafilyBalanseApiClient()
    private let localClient = CoreDataClient()
    
    
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
    
    func getOperations(filter: Filters) -> Observable<[Operation]> {
        return Observable
            .create { [weak self] result in
                //проверяем есть ли в базе данные за период, если нет запрашиваем у сервера
                let operations = self?.apiClient.getOperations(period: filter)
                result.onNext(operations!)
                //result.onError()
                
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
