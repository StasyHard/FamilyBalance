
import UIKit


final class OperationsTableViewProvider: NSObject, TableViewProvider {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: IncomeAndCostsCell.reuseIdD,
                    for: indexPath) as? IncomeAndCostsCell
                else { return UITableViewCell() }
            
            cell.incomeSumLabel.text = "+\(7000) ₽"
            cell.costsSumLabel.text = "-\(10000) ₽"
            let ratio: Float = 7000/(7000 + 10000)
            cell.incomeToCostsRatioView.progress = ratio
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
}
