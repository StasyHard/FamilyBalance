
import Foundation
import RxSwift

protocol Repository {
    func signIn(_ loginModel: LoginModel) -> Single<String>
}


final class AppRepository: Repository {
    
    private let apiClient = FafilyBalanseApiClient()
    private let localClient = CoreDataClient()
    
    func signIn(_ loginModel: LoginModel) -> Single<String> {
        return Single
            .create { single in
                
                self.apiClient.signIn(user: loginModel) { response in
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


//let default = UserDefaults.standard
//default.set(accessToken, forKey: "accessToken")
//default.synchronized()
////Now get like this and use guard so that it will prevent your crash if value is nil.
//guard let accessTokenValue = default.string(forKey: "accessToken") else {return}
//print(accessTokenValue)
