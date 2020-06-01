
import UIKit


protocol SignUpViewImplementation: class {
    func setActionsDelegate(delegate: SignUpViewActions)
}

protocol SignUpViewActions: class {

}


class SignUpView: UIView {

}



extension SignUpView: SignUpViewImplementation {
    
    func setActionsDelegate(delegate: SignUpViewActions) {
        
    }
}
