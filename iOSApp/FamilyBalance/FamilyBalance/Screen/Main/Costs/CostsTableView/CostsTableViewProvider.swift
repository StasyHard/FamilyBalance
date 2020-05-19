
import UIKit

class CostsTableViewProvider: NSObject, TableViewProvider {
    
    //MARK: - Open properties
    var categories = [CategoryViewModel]() 
    
    
    //MARK: - Private properties
    private let tableViewCellHeight: CGFloat = 30.0
    
    
    //MARK: - TableViewProvider metods
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        guard
            section == 0,
            let headerView = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: CostsPieChartHeaderView.reuseIdD)
                as? CostsPieChartHeaderView
            else { return nil }
        
        if !categories.isEmpty {
            headerView.updateChartData(categories: categories)
        } else {
            headerView.setNoDataText()
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView.frame.width
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewCellHeight
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CostTableViewCell.reuseIdD,
                for: indexPath) as? CostTableViewCell
            else { return UITableViewCell() }
        
        let category = categories[indexPath.row]
        
        cell.colorView.backgroundColor = category.color
        cell.categoryLabel.text = category.name
        cell.sumLabel.text = "\(category.sum) ₽"
        return cell
    }
    
    
    
    
}
