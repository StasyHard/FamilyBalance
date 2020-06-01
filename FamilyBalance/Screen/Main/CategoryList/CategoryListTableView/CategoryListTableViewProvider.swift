
import UIKit


class CategoryListTableViewProvider: NSObject, TableViewProvider {
    
    var categories = [Category]()
    private var selectedCategory: Category?
    
    
    //MARK: - Open metods
    func setSelectedCategory(_ category: Category) {
        selectedCategory = category
    }
    
    
    //MARK: - TableViewProvider
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: ListCell.reuseIdD,
                                 for: indexPath) as? ListCell
            else { return UITableViewCell() }
        
        let category = categories[indexPath.row]
        cell.titleLabel.text = category.title
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 40
//    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if categories[indexPath.row] == selectedCategory {
            cell.accessoryType = .checkmark
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if categories[indexPath.row] != selectedCategory {
            selectedCategory = categories[indexPath.row]
            tableView.reloadData()
        }
    }
}


