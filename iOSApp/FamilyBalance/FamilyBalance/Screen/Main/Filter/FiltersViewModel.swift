
import Foundation
import RxSwift
import RxCocoa


protocol FiltersViewModelObservable: class {
    var isClosed: Observable<Void> { get set }
    //var filterChanged: Observable<Void> { get set }
}

protocol FiltersViewActions: class {
    func closeButtonDidTapped()
    func showButtonTapped()
}


class FiltersViewModel: FiltersViewModelObservable {
    
    //MARK: - FiltersViewModelObservable
    var isClosed: Observable<Void>
    //var filterChanged: Observable<Void>
    
    
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
    
    func showButtonTapped() {
        
    }
}
