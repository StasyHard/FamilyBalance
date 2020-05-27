
import UIKit

protocol AddOperationViewImplementation: class {
    func setActionsDelegate(_ delegate: AddOperationViewActions)
    func setData()
}


final class AddOperationView: UIView {
    
    //MARK: - IBOutlet
    @IBOutlet private weak var operationControl: UISegmentedControl! {
        didSet {
            operationControl.backgroundColor =  AppColors.backgroundColor
        }
    }
    @IBOutlet private weak var addOperationTableView: UITableView! {
        didSet {
            addOperationTableView.backgroundColor = AppColors.backgroundColor
            addOperationTableView.separatorColor = .red
            registerCells()
            addOperationTableView.delegate = tableViewProvider
            addOperationTableView.dataSource = tableViewProvider
            addOperationTableView.tableFooterView = UIView()
        }
    }
    
    
    //MARK: - Private properties
    private var actionsDelegate: AddOperationViewActions?
    private let tableViewProvider = AddOperationTableViewProvider()
    
    
    //MARK: - IBAction
    @IBAction func incommeOrCostControlTapped(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            tableViewProvider.operation = .cost
        }
        if sender.selectedSegmentIndex == 1 {
            tableViewProvider.operation = .income
        }
        addOperationTableView.reloadData()
    }
    
    @IBAction func saveButtonTapped(_ sender: BlueRoundedButton) {
    }
    
    private func registerCells() {
        addOperationTableView.register(UINib(nibName: "SumOperationCell", bundle: nil), forCellReuseIdentifier: SumOperationCell.reuseIdD)
        addOperationTableView.register(UINib(nibName: "AddOperationCell", bundle: nil), forCellReuseIdentifier: AddOperationCell.reuseIdD)
    }
    
}



extension AddOperationView: AddOperationViewImplementation {
    func setActionsDelegate(_ delegate: AddOperationViewActions) {
        self.actionsDelegate = delegate
    }
    
    func setData() {
        
    }
    
    
}
