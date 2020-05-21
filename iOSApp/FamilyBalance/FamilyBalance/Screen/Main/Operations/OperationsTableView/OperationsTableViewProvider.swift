
import UIKit


struct OperationsInDayViewModel {
    let date: String
    let operations: [OperationModel]
}

struct OperationModel {
    var id: Int
    var category: String?
    var account: String
    var sum: Double
}


final class OperationsTableViewProvider: NSObject, TableViewProvider {
    
    var datesOperations = [
        OperationsInDayViewModel(date: "1.05.2020",
                                 operations: [OperationModel(id: 10,
                                                             category: nil,
                                                             account: "Наличные",
                                                             sum: 1000)]),
        OperationsInDayViewModel(date: "31.04.2020",
                                 operations: [OperationModel(id: 9,
                                                             category: "Продукты",
                                                             account: "Наличные",
                                                             sum: 200),
                                              OperationModel(id: 11,
                                                             category: "Развлечения",
                                                             account: "Наличные",
                                                             sum: 500)])
    ]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 + datesOperations.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 16
        } else {
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 95
        } else {
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return nil
        } else {
            return datesOperations[section - 1].date
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return datesOperations[section - 1].operations.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: IncomeAndCostsCell.reuseIdD,
                for: indexPath) as? IncomeAndCostsCell
                else { return UITableViewCell() }
            
            cell.incomeSumLabel.text = "+\(7000) ₽"
            cell.costsSumLabel.text = "-\(10000) ₽"
            let ratio: Float = 7000/(7000 + 10000)
            cell.incomeToCostsRatioView.progress = ratio
            
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CostCell.reuseIdD,
                for: indexPath) as? CostCell
                else { return UITableViewCell() }
            
            let dateInd = indexPath.section - 1
            let operation = datesOperations[dateInd].operations[indexPath.row]
            
            if operation.category == nil {
                cell.categoryLabel.text = operation.account
                cell.colorView.backgroundColor = .green
                cell.sumLabel.text = "+\(operation.sum)"
            } else {
                cell.categoryLabel.text = operation.category
                cell.colorView.backgroundColor = .red
                cell.sumLabel.text = "-\(operation.sum)"
            }
            
            cell.backgroundColor = .white
            return cell
        }
    }
    
    
}
