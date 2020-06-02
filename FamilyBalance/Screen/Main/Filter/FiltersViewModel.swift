
import Foundation
import RxSwift
import RxCocoa

//MARK: - Исправить чтоб был не стартовый и установленный, а один фильтр

protocol FiltersViewModelObservable: class {
    var isClosed: Observable<Void> { get set }
    var isSetFilter: Observable<PeriodFilter> { get set }
    var startFilter: Observable<PeriodFilter> { get set }
}

protocol FiltersViewActions: class {
    func closeButtonDidTapped()
    func showButtonTapped(filter: PeriodFilter)
}


class FiltersViewModel: FiltersViewModelObservable {
    
    //MARK: - FiltersViewModelObservable
    var isClosed: Observable<Void>
    var isSetFilter: Observable<PeriodFilter>
    var startFilter: Observable<PeriodFilter>
    
    
    //MARK: - Private properties
    private let _isClosed = PublishSubject<Void>()
    private let _isSetFilter = PublishSubject<PeriodFilter>()
    private let _startFilter = BehaviorSubject<PeriodFilter>(value: .mounth)
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Init
    init(startFilter: PeriodFilter) {
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
    
    func showButtonTapped(filter: PeriodFilter) {
        _isSetFilter.onNext(filter)
        _isClosed.onNext(())
    }
}
