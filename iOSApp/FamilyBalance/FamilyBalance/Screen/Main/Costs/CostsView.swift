
import UIKit
import Charts


protocol CostsViewImplementation: class {
    func setaAtionsDelegate(delegate: CostsViewActions)
    func setData(_ categories: [CategoryViewModel])
}


class CostsView: UIView {
    
    //MARK: - IBOutlet

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.backgroundColor = AppColors.backgroundColor
            registerCells()
            tableView.delegate = tableViewProvider
            tableView.dataSource = tableViewProvider
        }
    }
    
    
    //MARK: - Private properties
    private var actionsDelegate: CostsViewActions?
    //TODO: ------------------------------- Подумать где должна быть реализация
    private let tableViewProvider = CostsTableViewProvider()
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    //MARK: - Private metods
    private func setup() {
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: "CostCell", bundle: nil), forCellReuseIdentifier: CostCell.reuseIdD)
        tableView.register(UINib(nibName: "CostsPieChartHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: CostsPieChartHeaderView.reuseIdD)
    }
}



extension CostsView: CostsViewImplementation {
    func setaAtionsDelegate(delegate: CostsViewActions) {
        self.actionsDelegate = delegate
    }
    
    func setData(_ categories: [CategoryViewModel]) {
        tableViewProvider.categories = categories
        tableView.reloadData()
    }
}



extension CostsView: UITableViewDelegate {
    
}
