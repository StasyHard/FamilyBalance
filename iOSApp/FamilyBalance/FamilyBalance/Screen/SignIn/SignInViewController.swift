
import UIKit
import RxSwift
import RxCocoa


class SignInViewController: UIViewController {
    
    //MARK: - Open properties
    var viewModel: (SignInViewModelObservable & SignInViewActions)?
    
    
    //MARK: - Private properties
    private lazy var signInView = view as? SignInViewImplementation
    
    private let disposeBag = DisposeBag()

    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel = self.viewModel else { return }
        signInView?.setActionsDelegate(delegate: viewModel)
        observeViewModel(viewModel)
        configureDismissKeyboard()
    }
    
    
    //MARK: - Private metods
    
    //MARK: Observe on the ViewModel
    private func observeViewModel(_ viewModel: SignInViewModelObservable) {

        viewModel.isSignInActive
            .bind { [weak self] in self?.signInView?.isSignInActionsActive($0) }
            .disposed(by: self.disposeBag)
        
        viewModel.isLoading
            .filter { $0 }
            .bind { [weak self] _ in self?.signInView?.showLoading() }
            .disposed(by: self.disposeBag)
    }
}


