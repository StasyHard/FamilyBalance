
import UIKit
import RxSwift
import RxCocoa


class SignInViewController: UIViewController {
    
    //MARK: - Open properties
    var viewModel: (SignInViewModelObservable & SignInViewControllerActions)?
    
    
    //MARK: - Private properties
    private lazy var profileView = view as? SignInViewImplementation
    
    private let disposeBag = DisposeBag()

    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeViewModel()
        profileView?.setProvider(provider: self)
    }
    
    
    //MARK: - Private metods
    
    //MARK: Observe on the ViewModel
    private func observeViewModel() {
        guard let viewModel = self.viewModel else { return }
        
        viewModel.isSignInActiveObservable
            .bind { [weak self] in self?.profileView?.isSignInActionsActive($0) }
            .disposed(by: self.disposeBag)
        
        viewModel.isLoadingObservable
            .filter { $0 }
            .bind { [weak self] _ in self?.profileView?.showLoading() }
            .disposed(by: self.disposeBag)
    }
}



extension SignInViewController: SignInViewActions {
    func signInDidTapped(_ email: String, _ password: String) {
        viewModel?.signIn(email, password)
    }
    
    func signUpDidTapped() {
        viewModel?.signUp()
    }
}

