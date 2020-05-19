
import UIKit

class CostsTableViewProvider: NSObject, TableViewProvider {
    
    var categories = [CategoryViewModel]() 
    
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return categories.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CostTableViewCell.reuseIdD,
            for: indexPath) as? CostTableViewCell
            else { return UITableViewCell() }
        
            let category = categories[indexPath.row]
            
            cell.colorView.backgroundColor = category.color
            cell.categoryLabel.text = category.name
            cell.sumLabel.text = "\(category.sum) ₽"
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
           
            guard let headerView = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: CostsPieChartHeaderView.reuseIdD) as? CostsPieChartHeaderView
                else { return UITableViewHeaderFooterView() }
            
            if !categories.isEmpty {
                headerView.updateChartData(categories: categories)
            }
            return headerView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return tableView.frame.width
        } else {
            return 0
        }
    }
    
    
}
