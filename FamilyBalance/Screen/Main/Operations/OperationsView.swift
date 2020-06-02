
import UIKit

protocol OperationsViewImplementation: class {
    func setActionsDelegate(delegate: OperationsViewActions)
    func showOperationsByDays(_ operations: [DayOperationsUIModel])
    func showCostsSum(_ sum: Double)
    func showIncomeSum(_ sum: Double)
}


class OperationsView: UIView {
    
    //MARK: - Private properties
    private var actionsDelegate: OperationsViewActions?
    private let tableViewProvider = OperationsTableViewProvider()
    
    
    @IBOutlet private weak var operationsTableView: UITableView! {
        didSet {
            registerCells()
            operationsTableView.delegate = tableViewProvider
            operationsTableView.dataSource = tableViewProvider
        }
    }
    
    
    //MARK: - Private metods
    private func registerCells() {
        operationsTableView.register(UINib(nibName: "OperationsHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: OperationsHeaderView.reuseIdD)
        operationsTableView.register(UINib(nibName: "IncomeAndCostsCell", bundle: nil), forCellReuseIdentifier: OperationsRatioCell.reuseIdD)
        operationsTableView.register(UINib(nibName: "CostCell", bundle: nil), forCellReuseIdentifier: CostCell.reuseIdD)
    }
}



extension OperationsView: OperationsViewImplementation {

    func setActionsDelegate(delegate: OperationsViewActions) {
        self.actionsDelegate = delegate
    }
    
    func showCostsSum(_ sum: Double) {
        tableViewProvider.costsSum = sum
        operationsTableView.reloadData()
    }
    
    func showIncomeSum(_ sum: Double) {
        tableViewProvider.incomeSum = sum
        operationsTableView.reloadData()
    }
    
    func showOperationsByDays(_ operations: [DayOperationsUIModel]) {
        tableViewProvider.daysOperations = operations
        operationsTableView.reloadData()
    }
}
