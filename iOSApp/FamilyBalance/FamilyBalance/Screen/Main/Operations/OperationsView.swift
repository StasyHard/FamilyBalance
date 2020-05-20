
import UIKit

protocol OperationsViewImplementation: class {
    func setProvider(provider: OperationsViewActions)
}

protocol OperationsViewActions: class {
    
}


class OperationsView: UIView {
    
    //MARK: - Private properties
    private var provider: OperationsViewActions?
    //TODO: ------------------------------- Подумать где должна быть реализация
    private let tableViewProvider = OperationsTableViewProvider()
    
    
    @IBOutlet private weak var operationsTableView: UITableView! {
        didSet {
            operationsTableView.backgroundColor = AppColors.backgroundColor
            operationsTableView.delegate = tableViewProvider
            operationsTableView.dataSource = tableViewProvider
            registerCells()
        }
    }
    
    
    //MARK: - Private metods
    private func registerCells() {
        
    }
}



extension OperationsView: OperationsViewImplementation {
    
    func setProvider(provider: OperationsViewActions) {
        
    }
}
