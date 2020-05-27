
import UIKit


final class OperationsTableViewProvider: NSObject, TableViewProvider {
    
    //MARK: - Open properties
    var operationsByDays = [DayOperationsUIModel]()
    var costsSum: Double = 0.0
    var incomeSum: Double = 0.0
    
    //MARK: - TableViewProvider metods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 + operationsByDays.count
    }
    
        func tableView(_ tableView: UITableView,
                       heightForHeaderInSection section: Int) -> CGFloat {
            if section == 0 {
                return 16
            } else {
                return UITableView.automaticDimension
            }
        }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        guard
            section != 0,
            let headerView = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: OperationsHeaderView.reuseIdD) as? OperationsHeaderView
            else { return nil }
        let date = operationsByDays[section - 1].date
        headerView.dateLabel.text = Date.convertDateToString(date: date)
        headerView.summLabel.text = "\(operationsByDays[section - 1].sum) ₽"
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView,
                   willDisplayHeaderView view: UIView,
                   forSection section: Int) {
        let headerView = (view as? UITableViewHeaderFooterView)
        headerView?.tintColor = .clear
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return operationsByDays[section - 1].operations.count
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: IncomeAndCostsCell.reuseIdD,
                for: indexPath) as? IncomeAndCostsCell
                else { return UITableViewCell() }
            
            cell.incomeSumLabel.text = "+\(incomeSum) ₽"
            cell.costsSumLabel.text = "-\(costsSum) ₽"
            let ratio: Float = Float(incomeSum/(incomeSum + costsSum))
            cell.incomeToCostsRatioView.progress = ratio
            
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CostCell.reuseIdD,
                for: indexPath) as? CostCell
                else { return UITableViewCell() }
            
            let dateInd = indexPath.section - 1
            let operation = operationsByDays[dateInd].operations[indexPath.row]
            
            if operation.category == nil {
                cell.categoryLabel.text = operation.account.title
                cell.colorView.backgroundColor = .green
                cell.sumLabel.text = "+\(operation.sum) ₽"
            } else {
                cell.categoryLabel.text = operation.category?.title
                cell.colorView.backgroundColor = .red
                cell.sumLabel.text = "-\(operation.sum) ₽"
            }
            
            cell.backgroundColor = .white
            return cell
        }
    }
    
    
}
