
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


class CostsViewModel: CostsViewModelObservable {
    
    //MARK: - CostsViewModelActions
    var filtersTapped: Observable<Void>
    var categoryData: Observable<[CategoryViewModel]>
    
    
    //MARK: - Private properties
    private let _filtersTapped = PublishSubject<Void>()
    private let _categoryData = PublishSubject<[CategoryViewModel]>()
    
    private var filter: Filters = .mounth
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Init
    init() {
        filtersTapped = _filtersTapped
        categoryData = _categoryData
    }
    
    
    //MARK: - Open metods
    func wasSetFilter(filter: Filters) {
        if filter != self.filter {
            self.filter = filter
            
            var categories = [CategoryViewModel]()
            switch filter {
            case .today:
                categories = []
            case .week:
                categories = [
                    CategoryViewModel(id: 1,
                                      name: "Продукты",
                                      color: UIColor.red,
                                      sum: 100),
                    CategoryViewModel(id: 2,
                                      name: "Сладости",
                                      color: UIColor.blue,
                                      sum: 200)  ]
            case .mounth:
                categories = [
                    CategoryViewModel(id: 1,
                                      name: "Продукты",
                                      color: UIColor.red,
                                      sum: 100),
                    CategoryViewModel(id: 2,
                                      name: "Сладости",
                                      color: UIColor.blue,
                                      sum: 200),
                    CategoryViewModel(id: 3,
                                      name: "Развлечения",
                                      color: UIColor.lightGray,
                                      sum: 300),
                    CategoryViewModel(id: 4,
                                      name: "Для дома",
                                      color: UIColor.systemGreen,
                                      sum: 400) ]
            case .year:
                categories = [
                    CategoryViewModel(id: 1,
                                      name: "Продукты",
                                      color: UIColor.red,
                                      sum: 100)]
            }
            _categoryData.onNext(categories)
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
