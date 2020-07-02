
import Foundation
import RxSwift
import RxCocoa
//import CoreData


protocol CostsViewModelObservable: class {
    var filtersTapped: Observable<PeriodFilter> { get set }
    var categoryData: Observable<[CategoryUIModel]> { get set }
    var graphData: Observable<[CategoryGraphModel]> { get set }
    var costsSum: Observable<Double> { get set }
    var incomeSum: Observable<Double> { get set }
    var period: Observable<PeriodModel> { get set }
}

protocol CostsViewActions: class {
    func filtersDidTapped()
    func viewDidLoad()
}


final class CostsViewModel: CostsViewModelObservable {
    
    //MARK: - CostsViewModelActions
    var filtersTapped: Observable<PeriodFilter>
    var categoryData: Observable<[CategoryUIModel]>
    var graphData: Observable<[CategoryGraphModel]>
    var costsSum: Observable<Double>
    var incomeSum: Observable<Double>
    var period: Observable<PeriodModel>
    
    
    //MARK: - Private properties
    private let _filtersTapped = PublishSubject<PeriodFilter>()
    private let _categoryData = PublishSubject<[CategoryUIModel]>()
    private let _graphData = PublishSubject<[CategoryGraphModel]>()
    private let _costsSum = BehaviorSubject<Double>(value: 0.0)
    private let _incomeSum = BehaviorSubject<Double>(value: 0.0)
    private let _period = PublishSubject<PeriodModel>()
    
    private var repo: OperationsRepositoryImpl?
    private var filter: PeriodFilter = .mounth
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Init
    init(repo: OperationsRepositoryImpl) {
        filtersTapped = _filtersTapped
        categoryData = _categoryData
        incomeSum = _incomeSum
        costsSum = _costsSum
        graphData = _graphData
        period = _period
        
        self.repo = repo
    }
    
    
    //MARK: - Open metods
    //координатор вызывает функцию, когда на экране фильтров была нажата кнопка показать
    func wasSetFilter(filter: PeriodFilter) {
        
        if filter != self.filter {
            self.filter = filter
            getData()
        }
    }
    
    
    //MARK: - Private metods
    //получаем массив операций за запрошенный период и иреобразуем в необходимые для вью данные
    //общая сумма доходов, общая сумма расходов, категории для таблицы, категории для графика
    private func getData() {
        let period = FilterConverter.getPeriodByFilter(filter)
        _period.onNext(period)
        
        repo!.getOperations()
            .subscribe(
                onNext: { [weak self] operations in
                    guard let `self` = self else { return }
                    
                    let filteredperations = operations.filter { $0.date >= period.startDate }
                    
                    let income = filteredperations.filter { $0.category == nil }
                    let sumIncome = SumCalculator.getSum(by: income)
                    self._incomeSum.onNext(sumIncome)
                    
                    let costs = filteredperations.filter { $0.category != nil }
                    let sumCosts = SumCalculator.getSum(by: costs)
                    self._costsSum.onNext(sumCosts)
                    
                    let costsCategories = self.getCategories(by: costs)
                    self._categoryData.onNext(costsCategories)
                    
                    let graphCostsCaterories = self.getCategoriesForGraph(by: costsCategories)
                    self._graphData.onNext(graphCostsCaterories)
            })
            .disposed(by: self.disposeBag)
    }
    
    //получаем категории для таблицы из операций
    private func getCategories(by operations: [Operation]) -> [CategoryUIModel] {
        var categories = [CategoryUIModel]()
        
        if !operations.isEmpty {
            let resCategories = Dictionary(grouping: operations,
                                           by: {$0.category})
            
            categories = resCategories
                .reduce([]) { (result, resCategory) -> [CategoryUIModel] in
                    var result = result
                    let category = resCategory.key!
                    let operationsInCategory = resCategory.value
                    let sumOperations = SumCalculator.getSum(by: operationsInCategory)
                    
                    result.append(CategoryUIModel(name: category.title,
                                                  sum: sumOperations))
                    return result
            }
            
            categories = categories.sorted { $0.sum > $1.sum }
            categories = setCategoriesGraphColors(categories: categories)
        }
        return categories
    }
    
    //устанавливаем категориям цвета для графика
    private func setCategoriesGraphColors(categories: [CategoryUIModel]) -> [CategoryUIModel] {
        let colors = GraphColors.allCases
        for ind in 0..<categories.count {
            if ind < colors.count {
                categories[ind].color = colors[ind]
            }
            else {
                categories[ind].color = colors.last ??  GraphColors.systemGray
            }
        }
        return categories
    }
    
    //получаем категории для отображения на графике
    private func getCategoriesForGraph(by categories: [CategoryUIModel]) -> [CategoryGraphModel] {
        var graphCategories = [CategoryGraphModel]()
        if !categories.isEmpty {
            let groupedCategories = Dictionary(grouping: categories,
                                               by: {$0.color})
            
            graphCategories = groupedCategories
                .reduce([]) { (result, categories) -> [CategoryGraphModel] in
                    var result = result
                    let color = categories.key
                    let categoriesOneColor = categories.value
                    let sumCategories = SumCalculator.getSum(by: categoriesOneColor)
                    
                    result.append(CategoryGraphModel(color: color,
                                                     sum: sumCategories))
                    return result
            }
        }
        //категория с серым цветом должна быть последняя в массиве
        graphCategories = graphCategories.sorted { $0.sum > $1.sum }
        let ind = graphCategories.firstIndex { $0.color == .systemGray }
        guard let index = ind
            else { return graphCategories }
        let elem = graphCategories[index]
        graphCategories.remove(at: index)
        graphCategories.append(elem)
        return graphCategories
    }
}




extension CostsViewModel: CostsViewActions {
    func viewDidLoad() {
        getData()
    }
    
    func filtersDidTapped() {
        //передаем стартовый фильтр для экрана
        _filtersTapped.onNext((filter))
    }
}
