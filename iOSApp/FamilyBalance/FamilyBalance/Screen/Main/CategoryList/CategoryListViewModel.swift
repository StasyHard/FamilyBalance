
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
    private let _selectedCategory = PublishSubject<Category>()
    
    private let repo: Repository
    private let select: Category
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Init
    init(repo: Repository, selectedCategory: Category) {
        self.repo = repo
        
        self.catecories = _catecories
        self.selectedCategory = _selectedCategory
        self.select = selectedCategory
    }
}



extension CategoryListViewModel: CategoryListViewActions {
    func viewDidLoad() {
        repo.getCategories()
            .subscribe(onNext: { [weak self] categories in
                guard let `self` = self else { return }
                self._catecories.onNext(categories)
                self._selectedCategory.onNext(self.select)
            })
        .disposed(by: self.disposeBag)
    }
}
