
import UIKit

protocol AddOperationViewImplementation: class {
    func setActionsDelegate(_ delegate: AddOperationViewActions)
    func showDefaultAccount(account: Account)
    func showDefaultCategory(category: Category)

}

protocol AddOperationViewActions: class {
    func viewDidLoad()
    func accountButtonTapped()
    func categoryButtonTapped()
    //func DateButtonTapped()
    func saveOperationButtonTapped(sum: Double?, account: Account, category: Category?) 
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
            addOperationTableView.tableFooterView = UIView()
            
            addOperationTableView.delegate = tableViewProvider
            addOperationTableView.dataSource = tableViewProvider
            registerCells()
        }
    }
    
    
    //MARK: - Private properties
    private var actionsDelegate: AddOperationViewActions?
    private let tableViewProvider = AddOperationTableViewProvider()
    
    
    //MARK: - IBAction
    @IBAction private func incommeOrCostControlTapped(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            tableViewProvider.operation = .cost
        }
        if sender.selectedSegmentIndex == 1 {
            tableViewProvider.operation = .income
        }
        addOperationTableView.reloadData()
    }
    
    @IBAction private func saveButtonTapped(_ sender: BlueRoundedButton) {
        switch tableViewProvider.operation {
        case .income:
            actionsDelegate?.saveOperationButtonTapped(sum: tableViewProvider.sum,
                                                       account: tableViewProvider.defaultAccount!,
                                                       category: nil)
        case .cost:
            actionsDelegate?.saveOperationButtonTapped(sum: tableViewProvider.sum,
                                                       account: tableViewProvider.defaultAccount!,
                                                       category: tableViewProvider.defaultCategory!)
        }
    }
    
    
    //MARK: - Private metods
    private func registerCells() {
        addOperationTableView.register(UINib(nibName: "SumOperationCell", bundle: nil), forCellReuseIdentifier: SumOperationCell.reuseIdD)
        addOperationTableView.register(UINib(nibName: "AddOperationCell", bundle: nil), forCellReuseIdentifier: AddOperationCell.reuseIdD)
    }
}



extension AddOperationView: AddOperationViewImplementation {

    func setActionsDelegate(_ delegate: AddOperationViewActions) {
        self.actionsDelegate = delegate
        tableViewProvider.actionsDelegate = actionsDelegate
    }
    
    func showDefaultAccount(account: Account) {
        tableViewProvider.defaultAccount = account
        addOperationTableView.reloadData()
    }
    
    func showDefaultCategory(category: Category) {
        tableViewProvider.defaultCategory = category
        addOperationTableView.reloadData()
    }
    
    
}
