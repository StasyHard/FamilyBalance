
import Foundation

protocol SignUpViewModelObservable: class {
    
}

protocol SignUpViewControllerActions: class {
    
}



class SignUpViewModel: SignUpViewModelObservable {
    
    private let repository: OperationsRepositoryImpl
    
    
    //MARK: - Init
       init(repo: OperationsRepositoryImpl) {
           self.repository = repo
       }
    
}

extension SignUpViewModel: SignUpViewControllerActions {
    
}
