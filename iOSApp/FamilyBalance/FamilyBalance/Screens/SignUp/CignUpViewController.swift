
import UIKit
import RxSwift
import RxCocoa


class SignUpViewController: UIViewController {
    
    //MARK: - Open properties
    var viewModel: (SignUpViewControllerActions & SignUpViewModelObservable)?
    
    
    //MARK: - Private properties
    private lazy var signUpView = view as? SignUpViewImplementation
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeViewModel()
        signUpView?.setProvider(provider: self)
    }
    
    
    //MARK: - Private metods
    private func observeViewModel() {
        
    }
}



extension SignUpViewController: SignUpViewActions {
    
}
