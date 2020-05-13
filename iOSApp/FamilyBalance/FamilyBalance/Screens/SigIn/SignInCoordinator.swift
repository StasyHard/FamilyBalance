
import UIKit
import RxSwift
import RxCocoa


final class SignInCoordinator: BaseCoordirator {
    
    private let navController: UINavigationController
    private let repo: Repository
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Init
    init(navController: UINavigationController, repository: Repository) {
        self.navController = navController
        self.repo = repository
    }
    
    
    //MARK: - Open metods
    override func start() {
        let signInVC = UIStoryboard.instantiateSignInViewController()
        
        let viewModel = SignInViewModel()
        signInVC.viewModel = viewModel
        navController.setViewControllers([signInVC], animated: false)
        
        observeViewModel(viewModel)
    }
    
    //MARK: - Private metods
    private func observeViewModel(_ viewModel: SignInViewModelObservable) {
        
        viewModel.didSignInObservable
            .bind { [weak self] in
                guard let `self` = self else { return }
                self.didSignIn()
                self.parentCoordinator?.didFinish(coordinator: self)
        }
        .disposed(by: self.disposeBag)
        
        viewModel.signUpTappedObservable
            .bind { [weak self] in
                guard let `self` = self else { return }
                self.showSignUpModule()
        }
        .disposed(by: self.disposeBag)
    }
    
    private func showSignUpModule() {
        print("SignUpModule")
    }
    
    private func didSignIn() {
        //TODO: -----------------------------------------Обработать отсутствие листенера
        let handler: SignInListener? = findHandler()
        handler?.didSignIn()
    }
    
    // TODO: ----------------------------------------------------- почему не работает???
    //    private func findListeners(parent: Coordinator) -> SignInListener? {
    //        if parent is SignInListener {
    //            let parent = parent as! SignInListener
    //            return parent
    //        } else {
    //            guard let parent = parent.parentCoordinator else { return nil }
    //            findListener(parent: parent)
    //            return nil //не должно быть нил
    //        }
    //    }
    
}
