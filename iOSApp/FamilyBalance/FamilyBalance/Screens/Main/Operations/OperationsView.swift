
import UIKit

protocol OperationsViewImplementation: class {
    func setProvider(provider: OperationsViewActions)
}

protocol OperationsViewActions: class {

}


class OperationsView: UIView {

}



extension OperationsView: OperationsViewImplementation {
    
    func setProvider(provider: OperationsViewActions) {
        
    }
}
