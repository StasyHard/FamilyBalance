
import UIKit
import RxSwift
import RxCocoa

class SignUpCoordinator: BaseCoordirator {
    
    private let navController: UINavigationController
    private let repo: Repository
    
    private let disposeBag = DisposeBag()

    //MARK: - Init
    init(navController: UINavigationController, repo: Repository) {
        self.navController = navController
        self.repo = repo
    }
    
    override func start() {
        let signUpVC = UIStoryboard.instantiateSignUpVC()
        let viewModel = SignUpViewModel(repo: repo)
        signUpVC.viewModel = viewModel
        navController.pushViewController(signUpVC, animated: true)
        
        observeViewModel(viewModel)
    }
    
    private func observeViewModel(_ viewModel: SignUpViewModelObservable) {
        
    }

}
