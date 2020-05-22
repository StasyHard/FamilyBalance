
import Foundation
import RxSwift
import RxCocoa


protocol CostsViewModelObservable: class {
    var filtersTapped: Observable<Void> { get set }
    var categoryData: Observable<[CategoryUIModel]> { get set }
}

protocol CostsViewActions: class {
    func filtersDidTapped()
    
    func viewDidLoad()
}


final class CostsViewModel: CostsViewModelObservable {
    
    //MARK: - CostsViewModelActions
    var filtersTapped: Observable<Void>
    var categoryData: Observable<[CategoryUIModel]>
    
    
    //MARK: - Private properties
    private let _filtersTapped = PublishSubject<Void>()
    private let _categoryData = PublishSubject<[CategoryUIModel]>()
    
    private var repo: Repository?
    private var filter: Filters = .mounth
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Init
    init(repo: Repository) {
        filtersTapped = _filtersTapped
        categoryData = _categoryData
        
        self.repo = repo
    }
    
    
    //MARK: - Open metods
    //координатор вызывает функцию, когда на экране фильтров была нажата кнопка показать
    func wasSetFilter(filter: Filters) {
        
        if filter != self.filter {
            self.filter = filter
            
            getOperations()
        }
    }
    
    
    //MARK: - Private metods
    private func getOperations() {
        repo?.getOperations(filter: filter)
            .subscribe(
                onNext: { operations in
                    let categories = self.getCategories(by: operations)
                    self._categoryData.onNext(categories)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func getCategories(by operations: [Operation]) -> [CategoryUIModel] {
        var categories = [CategoryUIModel]()
        
        if operations.isEmpty { return categories }
        else {
            let filtered = operations.filter { $0.category != nil }
            let resCategories = Dictionary(grouping: filtered, by: {$0.category})
            
            categories = resCategories.reduce([]) { (result, resCategory) -> [CategoryUIModel] in
                var result = result
                let category = resCategory.key!
                let operationsInCategory = resCategory.value
                var sumOperations = 0.0

                operationsInCategory.forEach { sumOperations += $0.sum }
                result.append(CategoryUIModel(id: category.id,
                                             name: category.title,
                                             sum: sumOperations))
                return result
            }
            
            categories = categories.sorted { $0.sum > $1.sum }
            categories = setCategoriesGraphColors(categories: categories)
            
            return categories
        }
    }
    
    private func setCategoriesGraphColors(categories: [CategoryUIModel]) -> [CategoryUIModel] {
        let colors = [GraphColors.systemBlue, .systemRed, .systemGreen, .systemOrange, .systemYellow]
        for ind in 0..<categories.count {
            if ind < colors.count {
                categories[ind].color = colors[ind]
            }
            else {
                categories[ind].color = .systemGray
            }
        }
        return categories
    }
}




extension CostsViewModel: CostsViewActions {
    func viewDidLoad() {
        //-----------------------------------------------------------------------получить данные из сети
        getOperations()
    }
    
    func filtersDidTapped() {
        _filtersTapped.onNext(())
    }
}
