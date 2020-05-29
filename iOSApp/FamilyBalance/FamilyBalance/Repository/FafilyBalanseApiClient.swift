
import Foundation


class FafilyBalanseApiClient {
    
    func signIn(user: UserLoginModel, complition: @escaping (String?) -> Void) {
        let token: String? = "Token"
        
        complition(token)
    }
}
