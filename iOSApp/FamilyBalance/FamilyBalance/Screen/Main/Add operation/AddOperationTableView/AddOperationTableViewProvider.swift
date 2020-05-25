
import UIKit

enum OperationTable: Int {
    case income
    case cost
}


class AddOperationTableViewProvider: NSObject, TableViewProvider {
    
    var operation: OperationTable = .cost
    
    private let incomeCells = ["Сумма", "Счет", "Дата"]
    private let costCells = ["Сумма", "Счет", "Дата", "Категория"]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch operation {
        case .cost:
            return costCells.count
        case .income:
            return incomeCells.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch operation {
        case .cost:
            cell.textLabel?.text = costCells[indexPath.row]
        case .income:
            cell.textLabel?.text = incomeCells[indexPath.row]
        }
        return cell
    }
    
    
}
