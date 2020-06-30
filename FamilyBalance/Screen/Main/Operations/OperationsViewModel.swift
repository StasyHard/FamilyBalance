
import Foundation
import RxSwift
import RxCocoa


protocol OperationsViewModelObservable: class {
    var filtersTapped: Observable<PeriodFilter> { get set }
    var operationsByDays: Observable<[DayOperationsUIModel]> { get set }
    var costsSum: Observable<Double> { get set }
    var incomeSum: Observable<Double> { get set }
}

protocol OperationsViewActions: class {
    func viewDidLoad()
    func filtersDidTapped()
}


final class OperationsViewModel: OperationsViewModelObservable {
    
    //MARK: - OperationsViewModelObservable
    var filtersTapped: Observable<PeriodFilter>
    var operationsByDays: Observable<[DayOperationsUIModel]>
    var costsSum: Observable<Double>
    var incomeSum: Observable<Double>
    
    
    //MARK: - Private properties
    private let _filtersTapped = PublishSubject<PeriodFilter>()
    private let _operationsByDay = PublishSubject<[DayOperationsUIModel]>()
    private let _costsSum = BehaviorSubject<Double>(value: 0.0)
    private let _incomeSum = BehaviorSubject<Double>(value: 0.0)
    
    private let repo: Repository
    private var filter: PeriodFilter = .mounth
    private let sumCalculator = SumCalculator()
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Init
    init(repo: Repository) {
        operationsByDays = _operationsByDay
        costsSum = _costsSum
        incomeSum = _incomeSum
        filtersTapped = _filtersTapped
        
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
    //получаем операции и преобразовываем их в необходимые данные: массив операций сортированный по дням, общая сумма доходов, общая сумма расходов
    private func getData() {
        let result = repo.getOperations(byPeriod: getPeriodByFilter())
        
        result.0
            .subscribe(onNext: { [weak self] operations in
            guard let `self` = self else { return }
            
            let income = operations.filter { $0.category == nil }
            let sumIncome = self.sumCalculator.getSum(by: income)
            self._incomeSum.onNext(sumIncome)
            
            let costs = operations.filter { $0.category != nil }
            let sumCosts = self.sumCalculator.getSum(by: costs)
            self._costsSum.onNext(sumCosts)
            
            let operationsByDay = self.getOperationsByDays(operations: operations)
            self._operationsByDay.onNext(operationsByDay)
        })
        .disposed(by: self.disposeBag)
        
        
        switch result.1 {
        case Date().startOfCurrentMonth:
            filter = .mounth
        case Date().startOfCurrentDay:
            filter = .today
        case Date().startOfCurrentWeek:
            filter = .week
        case Date().startOfCurrentYear:
            filter = .year
        default:
            break
        }
    }
    
    //Преобразовываем filter в period
       private func getPeriodByFilter() -> PeriodModel {
           let endDate = Date().currentDate
           
           switch filter {
           case .mounth:
               let startOfCurrentMonth = Date().startOfCurrentMonth
               return PeriodModel(startDate: startOfCurrentMonth,
                             endDate: endDate)
           case .today:
               let startOfCurrentDay = Date().startOfCurrentDay
               return PeriodModel(startDate: startOfCurrentDay,
                             endDate: endDate)
           case .week:
               let startOfCurrentWeek = Date().startOfCurrentWeek
               return PeriodModel(startDate: startOfCurrentWeek,
                             endDate: endDate)
           case .year:
               let startOfCurrentYear = Date().startOfCurrentYear
               return PeriodModel(startDate: startOfCurrentYear,
                             endDate: endDate)
           }
       }
    
    //преобразовываем массив операций в ui модель, которая имеет поля: день, сумма операций за день, операции
    private func getOperationsByDays(operations: [Operation]) -> [DayOperationsUIModel] {
        var operationsByDay = [DayOperationsUIModel]()
        if !operations.isEmpty {
            
            let groupOperationByDay = Dictionary(grouping: operations) { $0.date.stripTime() }
            let sortedDates = groupOperationByDay.keys.sorted { $0 > $1 }
            
            for ind in 0..<sortedDates.count {
                let date = sortedDates[ind]
                let operations = groupOperationByDay[date]
                var sum = 0.0
                operations?.forEach {
                    if $0.category == nil { sum += $0.sum }
                    else { sum -= $0.sum }
                }
                
                operationsByDay.append(DayOperationsUIModel(date: date,
                                                            sum: sum,
                                                            operations: operations!))
            }
        }
        return operationsByDay
    }
}



extension OperationsViewModel: OperationsViewActions {
    
    func viewDidLoad() {
        getData()
    }
    
    func filtersDidTapped() {
        //передаем стартовый фильтр для экрана
        _filtersTapped.onNext((filter))
    }
}


