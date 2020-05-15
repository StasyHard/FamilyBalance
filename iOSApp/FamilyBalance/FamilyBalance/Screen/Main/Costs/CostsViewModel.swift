
import Foundation
import RxSwift

protocol CostsViewModelActions: class {
    var filter: Observable<Void> { get set }
}

protocol CostsViewActions: class {
    func filterDidTapped()
}


class CostsViewModel: CostsViewModelActions {
    
    //MARK: - CostsViewModelActions
    var filter: Observable<Void>
    
    
    //MARK: - Private properties
    private let _filter = PublishSubject<Void>()
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Init
    init() {
        filter = _filter
    }
}

extension CostsViewModel: CostsViewActions {
    func filterDidTapped() {
        _filter.onNext(())
    }
}
