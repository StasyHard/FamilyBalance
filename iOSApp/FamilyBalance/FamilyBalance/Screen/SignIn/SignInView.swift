
import UIKit


protocol SignInViewImplementation: class {
    func setActionsDelegate(delegate: SignInViewActions)
    
    func isSignInActionsActive(_ isActive: Bool)
    func showLoading()
}



final class SignInView: UIView {
    
    //MARK: - IBOutlet
    @IBOutlet private weak var emailTextField: BlueStrokeTextField! {
        didSet {
            setDelegate(textField: emailTextField)
        }
    }
    @IBOutlet private weak var passwordTextField: BlueStrokeTextField! {
        didSet {
            setDelegate(textField: passwordTextField)
        }
    }
    @IBOutlet private weak var logInButton: BlueRoundedButton!
    @IBOutlet private weak var signUpButton: BlueRoundedButton!
    
    
    //MARK: - Private properties
    private var actionsDelegate: SignInViewActions?
    private var loadingView: LoadingView?
    
    
    //MARK: - IBAction
    @IBAction private func signInTapped(_ sender: BlueRoundedButton) {
        guard let emailInput = emailTextField.text, !emailInput.isEmpty,
            let passwordInput = passwordTextField.text, !passwordInput.isEmpty
            else {
                checkInputData(emailTextField)
                checkInputData(passwordTextField)
                return
        }
        actionsDelegate?.signInDidTapped(emailInput, passwordInput)
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        actionsDelegate?.signUpDidTapped()
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Private metods
    func setDelegate(textField: UITextField) {
        textField.delegate = self
    }
    
    private func checkInputData(_ textField: BlueStrokeTextField) {
        if let textInput = textField.text, textInput.isEmpty {
            textField.showError()
            textField.resignFirstResponder()
        }
    }
}



//MARK: - SignInViewImplementation
extension SignInView: SignInViewImplementation {
    
    func setActionsDelegate(delegate: SignInViewActions) {
        self.actionsDelegate = delegate
    }
    
    func isSignInActionsActive(_ isActive: Bool) {
        logInButton.isEnabled = isActive
        signUpButton.isEnabled = isActive
        emailTextField.isEnabled = isActive
        passwordTextField.isEnabled = isActive
    }
    
    func showLoading() {
        loadingView = LoadingView(inView: self)
        loadingView?.startLoading()
    }
}



//MARK: - UITextFieldDelegate
extension SignInView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let textInput = textField.text, textInput.isEmpty {
            let textField = textField as? BlueStrokeTextField
            textField?.showError()
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let textField = textField as? BlueStrokeTextField
        textField?.textChanged()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            self.endEditing(true)
        default:
            self.endEditing(true)
        }
        return true
    }
}

