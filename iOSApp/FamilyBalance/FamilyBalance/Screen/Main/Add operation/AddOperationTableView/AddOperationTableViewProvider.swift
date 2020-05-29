
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
    
    //MARK: - Open properties
    var actionsDelegate: AddOperationViewActions?
    
    var operation: OperationTable = .cost
    var category: Category?
    var account: Account?
    var sum: Double?
    
    
    //MARK: - TableViewProvider metods
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
            cell.textFieldDelegate = self
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
                cell.button.setTitle(category?.title ?? "", for: .normal)
            }
            if cellType == .account {
                cell.button.setTitle(account?.title ?? "", for: .normal)
            }
            if cellType == .date {
                let date = Date().currentDate
                cell.button.setTitle(Date.convertDateToString(date: date), for: .normal)
            }
            
            return cell
        }
    }
}



//MARK: - UITextFieldDelegate
extension AddOperationTableViewProvider: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let inputText = textField.text ?? ""
        if !inputText.isEmpty {
            //textField.text = "\(inputText) ₽"
            sum = inputText.toDouble()
        }
    }
    
    private func toDouble(string: String) -> Double? {
        return NumberFormatter().number(from: string)?.doubleValue
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.endEditing(true)
        return true
    }
}



extension AddOperationTableViewProvider: AddOperationCellDelegate {
    
    func buttonInCellTapped(_ cell: AddOperationCell) {
        let buttonTitle = cell.button.titleLabel?.text
        if buttonTitle == CellType.account.rawValue {
            actionsDelegate?.accountButtonTapped()
        }
        if buttonTitle == CellType.category.rawValue {
            actionsDelegate?.categoryButtonTapped()
        }
        if buttonTitle == CellType.date.rawValue {
            print("Date tapped")
        }
    }

}
