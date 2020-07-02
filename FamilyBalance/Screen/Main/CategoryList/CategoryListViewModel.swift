
import Foundation
import RxSwift
import RxCocoa


protocol CategoryListViewModelObservable: class {
    var catecories: Observable<[Category]> { get set }
    var selectedCategory: Observable<Category> { get set }
}


final class CategoryListViewModel: CategoryListViewModelObservable {
    
    //MARK: - AddOperationViewModelObservable
    var catecories: Observable<[Category]>
    var selectedCategory: Observable<Category>
    
    
        //MARK: - Private properties
    private let _catecories = PublishSubject<[Category]>()
    private let _selectedCategory: BehaviorSubject<Category>
    
    private let repo: OperationsRepositoryImpl
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Init
    init(repo: OperationsRepositoryImpl, selectedCategory: Category) {
        self.repo = repo
        
        self.catecories = _catecories
        _selectedCategory = BehaviorSubject<Category>(value: selectedCategory)
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
    
    func wasSelectedCategory(category: Category) {
        _selectedCategory.onNext(category)
    }
}
