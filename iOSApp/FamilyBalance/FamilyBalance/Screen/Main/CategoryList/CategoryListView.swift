
import UIKit


protocol CategoryListViewImplementation {
    func setActionsDelegate(delegate: CategoryListViewActions)
    func showCategories(_ categories: [Category])
    func setSelectedCategory(_ category: Category)
}

protocol CategoryListViewActions: class {
    func viewDidLoad()
    func wasSelectedCategory(category: Category)
}


class CategoryListView: UIView {
    
    @IBOutlet weak var categoryListTableView: UITableView! {
        didSet {
            categoryListTableView.backgroundColor = AppColors.backgroundColor
            categoryListTableView.tableFooterView = UIView()
            
            categoryListTableView.delegate = tableViewProvider
            categoryListTableView.dataSource = tableViewProvider
        }
    }
    
    //private var actionsDelegate: CategoryListViewActions?
    private let tableViewProvider = CategoryListTableViewProvider()
}



extension CategoryListView: CategoryListViewImplementation {
    
    func setActionsDelegate(delegate: CategoryListViewActions) {
        //self.actionsDelegate = delegate
        tableViewProvider.actionDelegate = delegate
    }
    
    func showCategories(_ categories: [Category]) {
        tableViewProvider.categories = categories
        categoryListTableView.reloadData()
    }
    
    func setSelectedCategory(_ category: Category) {
        tableViewProvider.selectedCategory = category
        categoryListTableView.reloadData()
    }
}
