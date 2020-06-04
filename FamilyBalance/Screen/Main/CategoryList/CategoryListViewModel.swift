
import Foundation
import RxSwift
import RxCocoa


protocol CategoryListViewModelObservable: class {
    var catecories: Observable<[CategoryModel]> { get set }
    var selectedCategory: Observable<CategoryModel> { get set }
}


final class CategoryListViewModel: CategoryListViewModelObservable {
    
    //MARK: - AddOperationViewModelObservable
    var catecories: Observable<[CategoryModel]>
    var selectedCategory: Observable<CategoryModel>
    
    
        //MARK: - Private properties
    private let _catecories = PublishSubject<[CategoryModel]>()
    private let _selectedCategory: BehaviorSubject<CategoryModel>
    
    private let repo: Repository
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Init
    init(repo: Repository, selectedCategory: CategoryModel) {
        self.repo = repo
        
        self.catecories = _catecories
        _selectedCategory = BehaviorSubject<CategoryModel>(value: selectedCategory)
        self.selectedCategory = _selectedCategory
    }
}



extension CategoryListViewModel: CategoryListViewActions {
    
    func viewDidLoad() {
        repo.getCategories()
            .subscribe(onNext: { [weak self] categories in
                guard let `self` = self else { return }
                self._catecories.onNext(categories)
            })
        .disposed(by: self.disposeBag)
    }
    
    func wasSelectedCategory(category: CategoryModel) {
        _selectedCategory.onNext(category)
    }
}
