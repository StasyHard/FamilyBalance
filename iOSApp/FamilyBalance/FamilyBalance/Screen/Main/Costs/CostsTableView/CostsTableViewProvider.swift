
import UIKit

class CostsTableViewProvider: NSObject, TableViewProvider {
    
    var categories: [CategoryViewModel]?
    
    private let sectionCount = 2
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCount
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return categories?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CostTableViewCell.reuseIdD, for: indexPath) as? CostTableViewCell
            else { return UITableViewCell() }
        
        switch indexPath.section {
        case 0:
            break
        case 1:
            if let categories = self.categories {
                let category = categories[indexPath.row]
                
                cell.colorView.backgroundColor = category.color
                cell.categoryLabel.text = category.name
                cell.sumLabel.text = "\(category.sum) ₽"
            }
        default:
            break
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    private func titleTableViewCell() {
        
    }
    
    
}
