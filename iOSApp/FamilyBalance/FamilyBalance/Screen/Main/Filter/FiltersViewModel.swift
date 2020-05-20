
import Foundation
import RxSwift
import RxCocoa


protocol FiltersViewModelObservable: class {
    var isClosed: Observable<Void> { get set }
    var filter: Observable<Filters> { get set }
}

protocol FiltersViewActions: class {
    func closeButtonDidTapped()
    func showButtonTapped(filter: Filters)
}


class FiltersViewModel: FiltersViewModelObservable {
    
    //MARK: - FiltersViewModelObservable
    var isClosed: Observable<Void>
    var filter: Observable<Filters>
    
    
    //MARK: - Private properties
    private let _isClosed = PublishSubject<Void>()
    private let _filter = PublishSubject<Filters>()
    
    //MARK: - Init
    init() {
        isClosed = _isClosed
        filter = _filter
    }
}



extension FiltersViewModel: FiltersViewActions {
    
    func closeButtonDidTapped() {
        _isClosed.onNext(())
    }
    
    func showButtonTapped(filter: Filters) {
        _filter.onNext(filter)
        _isClosed.onNext(())
    }
}
