
import UIKit
import RxSwift
import RxCocoa


final class SignInCoordinator: BaseCoordirator {
    
    private let navController: UINavigationController
    private let repo: OperationsRepositoryImpl
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Init
    init(navController: UINavigationController, repo: OperationsRepositoryImpl) {
        self.navController = navController
        self.repo = repo
    }
    
    
    //MARK: - Open metods
    override func start() {
        let signInVC = UIStoryboard.instantiateSignInVC()
        let viewModel = SignInViewModel(repo: repo)
        signInVC.viewModel = viewModel
        navController.setViewControllers([signInVC], animated: false)
        
        observeViewModel(viewModel)
    }
    
    //MARK: - Private metods
    private func observeViewModel(_ viewModel: SignInViewModelObservable) {
        
        viewModel.didSignIn
            .bind { [weak self] in
                guard let `self` = self else { return }
                self.didSignIn()
                self.parentCoordinator?.didFinish(coordinator: self)
        }
        .disposed(by: self.disposeBag)
        
        viewModel.signUpTapped
            .bind { [weak self] in
                self?.showSignUpModule()
        }
        .disposed(by: self.disposeBag)
    }
    
    private func showSignUpModule() {
        let signUpCoordinator = SignUpCoordinator(navController: navController, repo: repo)
        childCoordinators.append(signUpCoordinator)
        signUpCoordinator.parentCoordinator = self
        signUpCoordinator.start()
    }
    
    private func didSignIn() {
        //TODO: -----------------------------------------Обработать отсутствие листенера
        let handler: SignInListener? = findHandler()
        handler?.didSignIn()
    }
    
}
