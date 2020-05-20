
import UIKit

enum Filters: String {
    case today = "Сегодня"
    case week = "Текущая неделя"
    case mounth = "Текущий месяц"
    case year = "Текущий год"
}


class FiltersTableViewProvider: NSObject, TableViewProvider {
    
    //MARK: - Private properties
    private let sectionsTitles = ["Период"]
    private let periodCellsType = [Filters.today, .week, .mounth, .year]
    
    private var selectedCellIndexPath: IndexPath = IndexPath(row: 2, section: 0)
    
    private let headerHeight: CGFloat = 20.0
    
    
    //MARK: - Open metods
//    func setAccounts() {
//        //TODO: добавить счета клиента в массив счетов
//    }
    
        func getFilter() -> Filters {
            var filterItem: Filters
            filterItem = periodCellsType[selectedCellIndexPath.row]
            return filterItem
        }
    
    
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
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return periodCellsType.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        switch indexPath.section {
        case 0:
            let title = periodCellsType[indexPath.row]
            cell.textLabel?.text = title.rawValue
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
