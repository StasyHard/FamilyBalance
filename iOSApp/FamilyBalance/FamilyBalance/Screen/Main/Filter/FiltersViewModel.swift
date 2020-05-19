
import Foundation
import RxSwift
import RxCocoa


protocol FiltersViewModelObservable: class {
    var isClosed: Observable<Void> { get set }
}

protocol FiltersViewActions: class {
    func closeButtonDidTapped()
}


class FiltersViewModel: FiltersViewModelObservable {
    
    //MARK: - FiltersViewModelObservable
    var isClosed: Observable<Void>
    
    
    //MARK: - Private properties
    private let _isClosed = PublishSubject<Void>()
    
    
    //MARK: - Init
    init() {
        isClosed = _isClosed
    }
}



extension FiltersViewModel: FiltersViewActions {
    func closeButtonDidTapped() {
        _isClosed.onNext(())
    }
}
