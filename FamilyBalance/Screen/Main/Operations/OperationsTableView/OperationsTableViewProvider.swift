
import UIKit


final class OperationsTableViewProvider: NSObject, TableViewProvider {
    
    //MARK: - Open properties
    var daysOperations = [DayOperationsUIModel]()
    var costsSum: Double = 0.0
    var incomeSum: Double = 0.0
    
    //MARK: - TableViewProvider metods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 + daysOperations.count
    }
    
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            if section == 0 {
                return 16
            } else {
                return UITableView.automaticDimension
            }
        }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            section != 0,
            let headerView = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: OperationsHeaderView.reuseIdD) as? OperationsHeaderView
            else { return nil }
        let date = daysOperations[section - 1].date
        headerView.dateLabel.text = Date.convertDateToString(date: date)

        let sum = daysOperations[section - 1].sum
        let sumLabelText: String
        if sum > 0 {
            sumLabelText = "+\(sum) ₽"
        }
        else {
            sumLabelText = "\(sum) ₽"
        }
        headerView.summLabel.text = sumLabelText

        return headerView
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = (view as? UITableViewHeaderFooterView)
        headerView?.tintColor = .clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return daysOperations[section - 1].operations.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: OperationsRatioCell.reuseIdD,
                for: indexPath) as? OperationsRatioCell
                else { return UITableViewCell() }
            
            cell.incomeSumLabel.text = "+\(incomeSum) ₽"
            cell.costsSumLabel.text = "-\(costsSum) ₽"
            let ratio: Float = Float(incomeSum/(incomeSum + costsSum))
            if ratio.isNaN {
                cell.ratioProgressView.progress = 0.5
            } else {
                cell.ratioProgressView.progress = ratio
            }
            
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CostCell.reuseIdD,
                for: indexPath) as? CostCell
                else { return UITableViewCell() }
            
            let dateInd = indexPath.section - 1
            let operation = daysOperations[dateInd].operations[indexPath.row]
            
            if operation.category == nil {
                cell.categoryLabel.text = operation.account.title
                cell.colorView.backgroundColor = .systemGreen
                cell.sumLabel.text = "+\(operation.sum) ₽"
            } else {
                cell.categoryLabel.text = operation.category?.title
                cell.colorView.backgroundColor = .systemRed
                cell.sumLabel.text = "-\(operation.sum) ₽"
            }
            
            cell.backgroundColor = .white
            return cell
        }
    }
    
    
}
