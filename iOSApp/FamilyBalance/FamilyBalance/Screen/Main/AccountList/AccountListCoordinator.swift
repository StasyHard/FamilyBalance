
import UIKit
import RxSwift
import RxCocoa


final class AccountListCoordinator: BaseCoordirator {
    
    //MARK: - Private properties
     private var navController: UINavigationController
     private var accountListNavController: UINavigationController
     
     private let repo: Repository
     
     private let disposeBag = DisposeBag()
     
     
     //MARK: - Init
     init(navController: UINavigationController, repo: Repository) {
         self.navController = navController
         self.repo = repo
         
         self.accountListNavController = UINavigationController()
     }
     
     override func start() {
        let accountListVC = UIStoryboard.instantiateAccountListVC()
    
        navController.present(accountListNavController, animated: true, completion: nil)
        accountListNavController.pushViewController(accountListVC, animated: false)
//         let categoryListVC = UIStoryboard.instantiateCategoryListVC()
//         let viewModel = CategoryListViewModel(repo: repo)
//         categoryListVC.viewModel = viewModel
//         navController.present(accountListNavController, animated: true, completion: nil)
//         accountListNavController.pushViewController(categoryListVC, animated: false)
         
//         observeViewModel(viewModel)
     }
     
     
     //MARK: - Private metods
     private func observeViewModel(_ viewModel: CategoryListViewModelObservable) {
         
     }
}
