
import UIKit
import RxSwift
import RxCocoa


final class CategoryListCoordinator: BaseCoordirator {
    
    //MARK: - Private properties
    private var navController: UINavigationController
    private var categoryListNavController: UINavigationController
    
    private let repo: Repository
    private let selectedCategory: CategoryModel
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Init
    init(navController: UINavigationController, repo: Repository, selectedCategory: CategoryModel) {
        self.navController = navController
        self.repo = repo
        self.selectedCategory = selectedCategory
        
        self.categoryListNavController = UINavigationController()
    }
    
    override func start() {
        let categoryListVC = UIStoryboard.instantiateCategoryListVC()
        let viewModel = CategoryListViewModel(repo: repo, selectedCategory: selectedCategory)
        categoryListVC.viewModel = viewModel
        navController.present(categoryListNavController, animated: true, completion: nil)
        categoryListNavController.pushViewController(categoryListVC, animated: false)
        
        observeViewModel(viewModel)
    }
    
    
    //MARK: - Private metods
    private func observeViewModel(_ viewModel: CategoryListViewModelObservable) {
        
        viewModel.selectedCategory
            .bind { [weak self] category in
                guard let `self` = self else { return }
                if category != self.selectedCategory {
                    self.dismiss()
                    let listener: CategoryListener? = self.findHandler()
                    listener?.setCategory(category)
                }
        }
        .disposed(by: self.disposeBag)
    }
    
    private func dismiss() {
        self.categoryListNavController.dismiss(animated: true, completion: nil)
        self.parentCoordinator?.didFinish(coordinator: self)
    }
}
