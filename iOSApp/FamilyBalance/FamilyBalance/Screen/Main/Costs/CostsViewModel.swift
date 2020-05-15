
import Foundation
import RxSwift

protocol CostsViewModelActions: class {

}

protocol CostsViewActions: class {
    func filterDidTapped()
}


class CostsViewModel: CostsViewModelActions {
    
}

extension CostsViewModel: CostsViewActions {
    func filterDidTapped() {
        
    }
}
