
import UIKit

protocol AddOperationViewImplementation: class {
    func setActionsDelegate(_ delegate: AddOperationViewActions)
    func setData()
}


final class AddOperationView: UIView {
    
    @IBOutlet weak var operationControl: UISegmentedControl!
    @IBOutlet weak var addOperationTableView: UITableView! {
        didSet {
            addOperationTableView.backgroundColor = AppColors.backgroundColor
            addOperationTableView.delegate = tableViewProvider
            addOperationTableView.dataSource = tableViewProvider
            addOperationTableView.tableFooterView = UIView()
        }
    }
    
        //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = AppColors.backgroundColor
    }

    
    //MARK: - Private properties
    private var actionsDelegate: AddOperationViewActions?
    private let tableViewProvider = AddOperationTableViewProvider()
    
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
    
}



extension AddOperationView: AddOperationViewImplementation {
    func setActionsDelegate(_ delegate: AddOperationViewActions) {
        self.actionsDelegate = delegate
    }
    
    func setData() {
        
    }
    
    
}
