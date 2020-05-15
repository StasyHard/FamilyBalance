
import Foundation

protocol SignUpViewModelObservable: class {
    
}

protocol SignUpViewControllerActions: class {
    
}



class SignUpViewModel: SignUpViewModelObservable {
    
    private let repository: Repository
    
    
    //MARK: - Init
       init(repo: Repository) {
           self.repository = repo
       }
    
}

extension SignUpViewModel: SignUpViewControllerActions {
    
}
