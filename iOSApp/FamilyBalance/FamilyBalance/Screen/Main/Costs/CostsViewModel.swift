
import Foundation
import RxSwift

protocol CostsViewModelActions: class {
    var filter: Observable<Void> { get set }
    var categoryData: Observable<[CategoryViewModel]> { get set }
}

protocol CostsViewActions: class {
    func filtersDidTapped()
}


class CostsViewModel: CostsViewModelActions {
    
    //MARK: - CostsViewModelActions
    var filter: Observable<Void>
    var categoryData: Observable<[CategoryViewModel]>
    
    
    //MARK: - Private properties
    private let _filter = PublishSubject<Void>()
    private let _categoryData = PublishSubject<[CategoryViewModel]>()
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Init
    init() {
        filter = _filter
        categoryData = _categoryData
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
                                         color: UIColor.yellow,
                                         sum: 300)
        let category4 = CategoryViewModel(id: 4,
                                         name: "Для дома",
                                         color: UIColor.green,
                                         sum: 400)
        
        return [category, category2, category3, category4]
    }
}

extension CostsViewModel: CostsViewActions {
    func viewDidLoad() {
        let categories = convertToCategoryViewModel()
        _categoryData.onNext(categories)
    }
    
    func filtersDidTapped() {
        _filter.onNext(())
    }
}
