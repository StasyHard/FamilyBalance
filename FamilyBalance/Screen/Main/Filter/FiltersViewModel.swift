
import Foundation
import RxSwift
import RxCocoa

//MARK: - Исправить чтоб был не стартовый и установленный, а один фильтр

protocol FiltersViewModelObservable: class {
    var isClosed: Observable<Void> { get set }
    var isSetFilter: Observable<Filters> { get set }
    var startFilter: Observable<Filters> { get set }
}

protocol FiltersViewActions: class {
    func closeButtonDidTapped()
    func showButtonTapped(filter: Filters)
}


class FiltersViewModel: FiltersViewModelObservable {
    
    //MARK: - FiltersViewModelObservable
    var isClosed: Observable<Void>
    var isSetFilter: Observable<Filters>
    var startFilter: Observable<Filters>
    
    
    //MARK: - Private properties
    private let _isClosed = PublishSubject<Void>()
    private let _isSetFilter = PublishSubject<Filters>()
    private let _startFilter = BehaviorSubject<Filters>(value: .mounth)
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Init
    init(startFilter: Filters) {
        self.isClosed = _isClosed
        self.isSetFilter = _isSetFilter
        self.startFilter = _startFilter
        
        _startFilter.onNext(startFilter)
    }
}



extension FiltersViewModel: FiltersViewActions {
    
    func closeButtonDidTapped() {
        _isClosed.onNext(())
    }
    
    func showButtonTapped(filter: Filters) {
        _isSetFilter.onNext(filter)
        _isClosed.onNext(())
    }
}
