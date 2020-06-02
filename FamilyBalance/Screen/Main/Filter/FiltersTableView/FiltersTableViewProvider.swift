
import UIKit


fileprivate enum FiltersSection: String, CaseIterable {
    case period = "Период"
}

enum PeriodFilter: String, CaseIterable {
    case today = "Сегодня"
    case week = "Текущая неделя"
    case mounth = "Текущий месяц"
    case year = "Текущий год"
}


class FiltersTableViewProvider: NSObject, TableViewProvider {
    
    //MARK: - Private properties
    private var selectedPeriodIndexPath: IndexPath?
    
    private let headerHeight: CGFloat = 25.0
    
    
    //MARK: - Open metods
    func getPeriodFilter() -> PeriodFilter {
        let filterItem = PeriodFilter.allCases[selectedPeriodIndexPath!.row]
        return filterItem
    }
    
    func setStartPeriodFilter(_ filer: PeriodFilter) {
        guard
            let row = PeriodFilter.allCases.firstIndex(of: filer),
            let section = FiltersSection.allCases.firstIndex(of: .period)
        else { return }
        selectedPeriodIndexPath = IndexPath(row: row, section: section)
    }
    
    
    //MARK: - TableViewProvider metods
    func numberOfSections(in tableView: UITableView) -> Int {
        return FiltersSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionTitle = FiltersSection.allCases[section].rawValue
        return sectionTitle
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = (view as? UITableViewHeaderFooterView)
        headerView?.tintColor = .clear
        headerView?.textLabel?.font.withSize(12)
        headerView?.textLabel?.textColor = AppColors.detailTextColor
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = FiltersSection.allCases[section]
        
        switch section {
        case .period :
            return PeriodFilter.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let section = FiltersSection.allCases[indexPath.section]
        
        switch section {
        case .period:
            let cellTitle = PeriodFilter.allCases[indexPath.row].rawValue
            cell.textLabel?.text = cellTitle
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath == selectedPeriodIndexPath {
            cell.accessoryType = .checkmark
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath != selectedPeriodIndexPath {
            selectedPeriodIndexPath = indexPath
            tableView.reloadData()
        }
    }
}
