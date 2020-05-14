
import UIKit


protocol SignUpViewImplementation: class {
    func setProvider(provider: SignUpViewActions)
}

protocol SignUpViewActions: class {

}


class SignUpView: UIView {

}



extension SignUpView: SignUpViewImplementation {
    
    func setProvider(provider: SignUpViewActions) {
        
    }
}
