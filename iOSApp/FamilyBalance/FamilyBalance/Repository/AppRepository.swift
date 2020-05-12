
import Foundation
import RxSwift


final class AppRepository {
    
    func signgIn(_ loginModel: LoginModel) -> Observable<LoginModel> {
        return Observable.of(loginModel)
    }
    
}
