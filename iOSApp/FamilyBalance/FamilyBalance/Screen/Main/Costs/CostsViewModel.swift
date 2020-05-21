
import Foundation
import RxSwift
import RxCocoa


protocol CostsViewModelObservable: class {
    var filtersTapped: Observable<Void> { get set }
    var categoryData: Observable<[CategoryViewModel]> { get set }
}

protocol CostsViewActions: class {
    func filtersDidTapped()
    
    func viewDidLoad()
}


final class CostsViewModel: CostsViewModelObservable {
    
    //MARK: - CostsViewModelActions
    var filtersTapped: Observable<Void>
    var categoryData: Observable<[CategoryViewModel]>
    
    
    //MARK: - Private properties
    private let _filtersTapped = PublishSubject<Void>()
    private let _categoryData = PublishSubject<[CategoryViewModel]>()
    
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
            
            repo?.getOperations(filter: filter)
                .subscribe(
                    onNext: { operations in
                        let categories = self.getCategories(by: operations)
                        self._categoryData.onNext(categories)
                })
                .disposed(by: self.disposeBag)
        }
    }
    
    private func getCategories(by operations: [Operation]) -> [CategoryViewModel] {
        let categories = [CategoryViewModel]()
        if operations.isEmpty { return categories }
        else {
            let costs = operations.filter { $0.category != nil }
            print(costs)
            
            
            
            return categories
        }
        
        
    }
    
    
    //MARK: - Private metods
    private func convertToCategoryViewModel() -> [CategoryViewModel] {
        //TODO: ------------------------логика преобразования модели ответа в модель вью
        let category = CategoryViewModel(id: 1,
                                         name: "Продукты",
                                         color: UIColor.red,
                                         sum: 100)
        let category2 = CategoryViewModel(id: 2,
                                          name: "Сладости",
                                          color: UIColor.blue,
                                          sum: 200)
        let category3 = CategoryViewModel(id: 3,
                                          name: "Развлечения",
                                          color: UIColor.lightGray,
                                          sum: 300)
        let category4 = CategoryViewModel(id: 4,
                                          name: "Для дома",
                                          color: UIColor.systemGreen,
                                          sum: 400)
        
        return [category4, category3, category2, category]
    }
}

extension CostsViewModel: CostsViewActions {
    func viewDidLoad() {
        //-----------------------------------------------------------------------получить данные из сети
        let categories = convertToCategoryViewModel()
        _categoryData.onNext(categories)
    }
    
    func filtersDidTapped() {
        _filtersTapped.onNext(())
    }
}
