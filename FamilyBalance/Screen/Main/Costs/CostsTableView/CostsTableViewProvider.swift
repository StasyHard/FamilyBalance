
import UIKit

class CostsTableViewProvider: NSObject, TableViewProvider {
    
    //MARK: - Open properties
    var graphCategories = [CategoryGraphModel]()
    var categories = [CategoryUIModel]()
    var costsSum: Double = 0.0
    var incomeSum: Double = 0.0
    var period: Period?
    
    
    //MARK: - Private properties
    private let tableViewCellHeight: CGFloat = 40.0
    
    
    //MARK: - TableViewProvider metods
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        guard
            section == 0,
            let headerView = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: CostsPieChartHeaderView.reuseIdD)
                as? CostsPieChartHeaderView
            else { return nil }
        
        if let period = period {
            let startDate = Date.convertDateToString(date: period.startDate)
            let endDate = Date.convertDateToString(date: period.endDate)
            headerView.dateLabel.text = "\(startDate) - \(endDate)"
        } else {
            headerView.dateLabel.text = ""
        }

        headerView.incomeSumLabel.text = "\(incomeSum) ₽"
        headerView.costsSumLabel.text = "\(costsSum) ₽"
        headerView.updateUI(categories: graphCategories)

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView.frame.width - 50
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CategoryCell.reuseIdD,
                for: indexPath) as? CategoryCell
            else { return UITableViewCell() }
        
        let category = categories[indexPath.row]
        let color = category.getUIcolorFromGraphColor(category.color)
        cell.colorView.backgroundColor = color
        cell.backgroundColorView.backgroundColor = color.withAlphaComponent(0.3)
        cell.categoryLabel.text = category.name
        cell.sumLabel.text = "\(category.sum) ₽"
        return cell
    }
}
