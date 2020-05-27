
import UIKit

enum OperationTable: Int {
    case income
    case cost
}

fileprivate enum IncomeCellsType: String, CaseIterable {
    case sum = "Сумма"
    case account = "Счет"
    case date = "Дата"
    
}

fileprivate enum CostCellsType: String, CaseIterable {
    case sum = "Сумма"
    case account = "Счет"
    case date = "Дата"
    case category = "Категория"
}


class AddOperationTableViewProvider: NSObject, TableViewProvider {
    
    var operation: OperationTable = .cost
    var categories = [Category(id: 1, title: "Продукты"), Category(id: 2, title: "Развлечения")]
    var accounts = [Account(id: 1, title: "Наличные"), Account(id: 2, title: "Карта")]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch operation {
        case .cost:
            return CostCellsType.allCases.count
        case .income:
            return IncomeCellsType.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch operation {
        case .cost:
            let costCellType = CostCellsType.allCases[indexPath.row]
            if costCellType == .sum {
                
                guard let cell = tableView
                    .dequeueReusableCell(withIdentifier: SumOperationCell.reuseIdD,
                                         for: indexPath) as? SumOperationCell
                    else { return UITableViewCell() }
                
                cell.sumLabel.text = costCellType.rawValue
                return cell
            }
            else {
                guard let cell = tableView
                    .dequeueReusableCell(withIdentifier: AddOperationCell.reuseIdD,
                                         for: indexPath) as? AddOperationCell
                    else { return UITableViewCell() }
                
                cell.label.text = costCellType.rawValue
                
                if costCellType == .category {
                    cell.button.setTitle(categories[0].title, for: .normal)
                }
                if costCellType == .account {
                    cell.button.setTitle(accounts[0].title, for: .normal)
                }
                if costCellType == .date {
                    let date = Date().currentDate
                    cell.button.setTitle(Date.convertDateToString(date: date), for: .normal)
                }
                
                return cell
            }
            
        case .income:
            let incomeCellType = IncomeCellsType.allCases[indexPath.row]
            if incomeCellType == .sum {
                
                guard let cell = tableView
                    .dequeueReusableCell(withIdentifier: SumOperationCell.reuseIdD,
                                         for: indexPath) as? SumOperationCell
                    else { return UITableViewCell() }
                
                cell.sumLabel.text = incomeCellType.rawValue
                return cell
            }
            else {
                guard let cell = tableView
                    .dequeueReusableCell(withIdentifier: AddOperationCell.reuseIdD,
                                         for: indexPath) as? AddOperationCell
                    else { return UITableViewCell() }
                
                cell.label.text = incomeCellType.rawValue
                
                if incomeCellType == .account {
                    cell.button.titleLabel?.text = accounts[0].title
                }
                
                return cell
            }
        }
    }
    
    
}
