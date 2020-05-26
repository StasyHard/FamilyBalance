
import UIKit

protocol OperationsViewImplementation: class {
    func setActionsDelegate(delegate: OperationsViewActions)
}


class OperationsView: UIView {
    
    //MARK: - Private properties
    private var actionsDelegate: OperationsViewActions?
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
        operationsTableView.register(UINib(nibName: "IncomeAndCostsCell", bundle: nil), forCellReuseIdentifier: IncomeAndCostsCell.reuseIdD)
        operationsTableView.register(UINib(nibName: "CostCell", bundle: nil), forCellReuseIdentifier: CostCell.reuseIdD)
    }
}



extension OperationsView: OperationsViewImplementation {
    
    func setActionsDelegate(delegate: OperationsViewActions) {
        self.actionsDelegate = delegate
    }
}
