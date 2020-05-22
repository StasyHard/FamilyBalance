
import Foundation
import RxSwift
import RxCocoa


protocol CostsViewModelObservable: class {
    var filtersTapped: Observable<Void> { get set }
    var categoryData: Observable<[CategoryUIModel]> { get set }
    var costsSum: Observable<Double> { get set }
    var incomeSum: Observable<Double> { get set }
}

protocol CostsViewActions: class {
    func filtersDidTapped()
    
    func viewDidLoad()
}


final class CostsViewModel: CostsViewModelObservable {
    
    //MARK: - CostsViewModelActions
    var filtersTapped: Observable<Void>
    var categoryData: Observable<[CategoryUIModel]>
    var costsSum: Observable<Double>
    var incomeSum: Observable<Double>
    
    
    //MARK: - Private properties
    private let _filtersTapped = PublishSubject<Void>()
    private let _categoryData = PublishSubject<[CategoryUIModel]>()
    private let _costsSum = BehaviorSubject<Double>(value: 0.0)
    private let _incomeSum = BehaviorSubject<Double>(value: 0.0)
    
    private var repo: Repository?
    private var filter: Filters = .mounth
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Init
    init(repo: Repository) {
        filtersTapped = _filtersTapped
        categoryData = _categoryData
        incomeSum = _incomeSum
        costsSum = _costsSum
        
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
                onNext: { /*[weak self]*/ operations in
                    let income = operations.filter { $0.category == nil }
//                    if !income.isEmpty {
//                        let sum = self.getSum(by: income)
//                        self._incomeSum.onNext(sum)
//                    }
                    let costs = operations.filter { $0.category != nil }
//                    if !costs.isEmpty {
//                        let sum = self.getSum(by: costs)
//                        self._costsSum.onNext(sum)
//                    }
                    let costsCategories = self.getCategories(by: costs)
                    self._categoryData.onNext(costsCategories)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func getSum(by operations: [Operation]) -> Double {
        var sum = 0.0
        operations.forEach { sum += $0.sum}
        return sum
    }
    
    private func getCategories(by operations: [Operation]) -> [CategoryUIModel] {
        var categories = [CategoryUIModel]()
        if operations.isEmpty { return categories }
        else {
            let resCategories = Dictionary(grouping: operations, by: {$0.category})
            
            categories = resCategories.reduce([]) { (result, resCategory) -> [CategoryUIModel] in
                var result = result
                let category = resCategory.key!
                let operationsInCategory = resCategory.value
                let sumOperations = getSum(by: operationsInCategory)
                
                //operationsInCategory.forEach { sumOperations += $0.sum }
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
