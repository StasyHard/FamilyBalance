
import Foundation


class FafilyBalanseApiClient {
    
    func signIn(user: LoginModel, complition: @escaping (String?) -> Void) {
        let token: String? = "Token"
        
        complition(token)
    }
}
