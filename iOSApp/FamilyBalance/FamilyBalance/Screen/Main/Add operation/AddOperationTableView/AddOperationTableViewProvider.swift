
import UIKit

enum OperationTable: Int {
    case income
    case cost
}

fileprivate enum CellType: String, CaseIterable {
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
            return CellType.allCases.count
        case .income:
            return CellType.allCases.count - 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = CellType.allCases[indexPath.row]
        
        if cellType == .sum {
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: SumOperationCell.reuseIdD,
                                     for: indexPath) as? SumOperationCell
                else { return UITableViewCell() }
            
            cell.sumLabel.text = cellType.rawValue
            return cell
        }
        
        else {
            guard let cell = tableView
            .dequeueReusableCell(withIdentifier: AddOperationCell.reuseIdD,
                                 for: indexPath) as? AddOperationCell
            else { return UITableViewCell() }
            
            cell.delegate = self
            cell.label.text = cellType.rawValue
            
            if cellType == .category {
                cell.button.setTitle(categories[0].title, for: .normal)
            }
            if cellType == .account {
                cell.button.setTitle(accounts[0].title, for: .normal)
            }
            if cellType == .date {
                let date = Date().currentDate
                cell.button.setTitle(Date.convertDateToString(date: date), for: .normal)
            }
            
            return cell
        }
    }
}



extension AddOperationTableViewProvider: AddOperationCellDelegate {
    
    func didTapButtonInCell(_ cell: AddOperationCell) {
        let button = cell.button.titleLabel?.text
        print(button)
    }
    
    
}
