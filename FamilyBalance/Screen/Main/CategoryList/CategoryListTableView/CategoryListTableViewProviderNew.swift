
import UIKit


class CategoryListTableViewProvider: NSObject, TableViewProvider {
    
    var categories = [CategoryModel]()
    var selectedCategory: CategoryModel?
    
    var actionDelegate: CategoryListViewActions?
    
    //MARK: - TableViewProvider
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if categories[indexPath.row] == selectedCategory {
            cell.accessoryType = .checkmark
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        if categories[indexPath.row] != selectedCategory {
            selectedCategory = categories[indexPath.row]
            actionDelegate?.wasSelectedCategory(category: selectedCategory!)
        }
    }
    
}
