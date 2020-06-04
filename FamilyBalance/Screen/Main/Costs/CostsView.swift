
import UIKit
import Charts


protocol CostsViewImplementation: class {
    func setaAtionsDelegate(delegate: CostsViewActions)
    func showCategories(_ categories: [CategoryUIModel])
    func showGraphCategories(_ categorise: [CategoryGraphModel])
    func showIncomeSum(_ sum: Double)
    func showCostsSum(_ sum: Double)
    func showPeriod(_ period: PeriodModel)
}


class CostsView: UIView {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            registerCells()
            tableView.delegate = tableViewProvider
            tableView.dataSource = tableViewProvider
        }
    }
    
    
    //MARK: - Private properties
    private var actionsDelegate: CostsViewActions?
    private let tableViewProvider = CostsTableViewProvider()
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: CategoryCell.reuseIdD)
        tableView.register(UINib(nibName: "CostsPieChartHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: CostsPieChartHeaderView.reuseIdD)
    }
}



extension CostsView: CostsViewImplementation {
    
    func setaAtionsDelegate(delegate: CostsViewActions) {
        self.actionsDelegate = delegate
    }
    
    func showPeriod(_ period: PeriodModel) {
        tableViewProvider.period = period
        tableView.reloadData()
    }
    
    func showIncomeSum(_ sum: Double) {
        tableViewProvider.incomeSum = sum
        tableView.reloadData()
    }
    
    func showCostsSum(_ sum: Double) {
        tableViewProvider.costsSum = sum
        tableView.reloadData()
    }
    
    func showCategories(_ categories: [CategoryUIModel]) {
        tableViewProvider.categories = categories
        tableView.reloadData()
    }
    
    func showGraphCategories(_ categorise: [CategoryGraphModel]) {
        tableViewProvider.graphCategories = categorise
        tableView.reloadData()
    }
}

