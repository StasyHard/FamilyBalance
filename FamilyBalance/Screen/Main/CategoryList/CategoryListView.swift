
import UIKit


protocol CategoryListViewImplementation {
    func setActionsDelegate(delegate: CategoryListViewActions)
    func showCategories(_ categories: [CategoryModel])
    func setSelectedCategory(_ category: CategoryModel)
}

protocol CategoryListViewActions: class {
    func viewDidLoad()
    func wasSelectedCategory(category: CategoryModel)
}


class CategoryListView: UIView {
    
    @IBOutlet weak var categoryListTableView: UITableView! {
        didSet {            
            categoryListTableView.delegate = tableViewProvider
            categoryListTableView.dataSource = tableViewProvider
        }
    }
    
    private let tableViewProvider = CategoryListTableViewProvider()
}



extension CategoryListView: CategoryListViewImplementation {
    
    func setActionsDelegate(delegate: CategoryListViewActions) {
        tableViewProvider.actionDelegate = delegate
    }
    
    func showCategories(_ categories: [CategoryModel]) {
        tableViewProvider.categories = categories
        categoryListTableView.reloadData()
    }
    
    func setSelectedCategory(_ category: CategoryModel) {
        tableViewProvider.selectedCategory = category
        categoryListTableView.reloadData()
    }
}
