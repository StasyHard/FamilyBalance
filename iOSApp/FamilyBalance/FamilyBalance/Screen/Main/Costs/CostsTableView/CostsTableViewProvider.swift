
import UIKit

class CostsTableViewProvider: NSObject, TableViewProvider {
    
    var categories: [CategoryViewModel]?
    
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCostsTableViewCell.reuseIdD, for: indexPath) as? CategoryCostsTableViewCell
            else { return UITableViewCell() }
        
        if let categories = self.categories {
            let category = categories[indexPath.row]
            
            cell.colorView.backgroundColor = category.color
            cell.categoryLabel.text = category.name
            cell.sumLabel.text = "\(category.sum) ₽"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
}
