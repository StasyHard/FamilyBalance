
import Foundation
import RxSwift
import RxCocoa


protocol OperationsViewModelObservable: class {
}

protocol OperationsViewActions: class {
    func viewDidLoad()
}


final class OperationsViewModel: OperationsViewModelObservable {
    
    //MARK: - Private properties
    private let repo: Repository
    private var filter: Filters = .mounth
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Init
    init(repo: Repository) {
        self.repo = repo
    }
    
    func getData() {
        repo.getOperations(filter: filter)
            .subscribe(onNext: { operations in
                //guard let `self` = self else { return }
                
                self.getOperationsByDays(operations: operations)
            })
        .disposed(by: self.disposeBag)
    }
    
    private func getOperationsByDays(operations: [Operation]) {

    }
}



extension OperationsViewModel: OperationsViewActions {
    func viewDidLoad() {
        getData()
    }
}


