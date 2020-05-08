
import UIKit
import RxSwift
import RxCocoa

final class SignInCoordinator: Coordinator {
    
    private let navController: UINavigationController
    
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    private let disposeBag = DisposeBag()
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    func start() {
        let signInVC = UIStoryboard.instantiateSignInViewController()
        let viewModel = SignInViewModel()
        signInVC.viewModel = viewModel
        navController.setViewControllers([signInVC], animated: false)
        navController.navigationBar.isHidden = true
        
        observeViewModel(viewModel)
    }
    
    private func observeViewModel(_ viewModel: SingInViewModelProtocol) {
        viewModel.didSignInObservable
            .bind { [weak self] in
                guard let `self` = self else { return }
                //TODO -------------------------------------отправить на app coordinator
                self.showMainModule()
                self.parentCoordinator?.didFinish(coordinator: self)
        }
         .disposed(by: self.disposeBag)
    }
    
    private func showMainModule() {
        let mainCoordinator = MainCoordinator(navController: navController)
        childCoordinators.append(mainCoordinator)
        mainCoordinator.start()
    }
    
    
}


