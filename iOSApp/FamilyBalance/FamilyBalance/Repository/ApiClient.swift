
import Foundation


class ApiClient {
    
    func signIn(user: LoginModel, complition: @escaping (String?) -> Void) {
        let token: String? = "Token"
        
        Keys.TOKEN = token ?? ""
        
        complition(token)
    }
}
