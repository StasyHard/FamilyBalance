
import UIKit


protocol CategoryListViewImplementation {
    func showCategories(_ categories: [Category])
    func setSelectedCategory(_ category: Category)
}

protocol CategoryListViewActions: class {
    func viewDidLoad()
}

class CategoryListView: UIView {

     //MARK: - IBOutlet
    @IBOutlet weak var categoryListTableView: UITableView! {
        didSet {
            categoryListTableView.backgroundColor = AppColors.backgroundColor
            categoryListTableView.tableFooterView = UIView()
            registerCells()
            categoryListTableView.delegate = tableViewProvider
            categoryListTableView.dataSource = tableViewProvider
        }
    }
    
    
    //MARK: - Private properties
    private var actionsDelegate: AddOperationViewActions?
    private let tableViewProvider = CategoryListTableViewProvider()
    
    private func registerCells() {
       categoryListTableView.register(UINib(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: ListCell.reuseIdD)
    }
}

extension CategoryListView: CategoryListViewImplementation {
    
    func showCategories(_ categories: [Category]) {
        tableViewProvider.categories = categories
        categoryListTableView.reloadData()
    }
    
    func setSelectedCategory(_ category: Category) {
        print(category)
        tableViewProvider.setSelectedCategory(category)
    }
}
