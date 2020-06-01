
import UIKit
import RxSwift
import RxCocoa
import Charts


final class CategoryListViewController: UIViewController {
    
    //MARK: - Open properties
    var viewModel: (CategoryListViewModelObservable & CategoryListViewActions)?
    
    
    //MARK: - Private properties
    private lazy var categoryListView = view as? CategoryListView
    
    private let disposeBag = DisposeBag()
    
    
 //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationUI()
        
        guard let viewModel = viewModel else { return }
        //categoryListView?.setActionsDelegate(viewModel)
        observeViewModel(viewModel)

        viewModel.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
       //закрытие экрана должно отправлять в координатор эвент о закрытии
    }
    
    
        //MARK: - Private metods
    private func setNavigationUI() {
            title = "Выбрать категорию"
        }
    
    private func observeViewModel(_ viewModel: CategoryListViewModelObservable) {
        
        viewModel.catecories
            .bind { [weak self] categories in
                self?.categoryListView?.showCategories(categories)
        }
        .disposed(by: self.disposeBag)
        
        viewModel.selectedCategory
            .bind { [weak self] category in
                self?.categoryListView?.setSelectedCategory(category)
        }
        .disposed(by: self.disposeBag)
    }
}
