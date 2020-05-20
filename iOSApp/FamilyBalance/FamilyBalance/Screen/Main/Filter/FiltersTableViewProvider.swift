
import UIKit

enum Filters {
    case today(title: String)
    case week(title: String)
    case mounth(title: String)
    case year(title: String)
}

class FiltersTableViewProvider: NSObject, TableViewProvider {
    
    //MARK: - Private properties
    private let sectionsTitles = ["Счет", "Период"]
    private var accountCellsTitles = ["Все счета"]
    private let periodCellsTitles = ["Сегодня", "Текущая неделя", "Текущий месяц", "Текущий год"]
    //private let selectPeriodCellTitle = ["Выбрать период"]
    
    private var selectedCellIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    
    private let headerHeight: CGFloat = 20.0
    
    
    //MARK: - Open metods
    func setAccounts() {
        //TODO: добавить счета клиента в массив счетов
    }
    
//    func getFilter() -> FilterItem {
//        var filterItem: FilterItem
//        if selectedCellIndexPath.section == 0 {
//            filterTitle = accountCellsTitles[selectedCellIndexPath.row]
//        } else if selectedCellIndexPath.section == 1 {
//            filterTitle = accountCellsTitles[selectedCellIndexPath.row]
//        }
//        
//        return filterItem
//    }
    
    
    //MARK: - TableViewProvider metods
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsTitles.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return sectionsTitles[section]
        case 1:
            return sectionsTitles[section]
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return accountCellsTitles.count
        case 1:
            return periodCellsTitles.count
            //case 2:
        //    return selectPeriodCellTitle.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        switch indexPath.section {
        case 0:
            let title = accountCellsTitles[indexPath.row]
            cell.textLabel?.text = title
        case 1:
            let title = periodCellsTitles[indexPath.row]
            cell.textLabel?.text = title
            //case 2:
            //let title = selectPeriodCellTitle[indexPath.row]
        //cell.textLabel?.text = title
        default:
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath == selectedCellIndexPath {
            cell.accessoryType = .checkmark
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath != selectedCellIndexPath {
            selectedCellIndexPath = indexPath
            tableView.reloadData()
        }
    }
}
