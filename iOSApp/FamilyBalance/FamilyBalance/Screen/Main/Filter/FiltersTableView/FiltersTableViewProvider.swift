
import UIKit


class FiltersTableViewProvider: NSObject, TableViewProvider {
    
    //MARK: - Private properties
    private let sectionsTitles = ["Период"]
    private let periodCellsType = [Filters.today, .week, .mounth, .year]
    
    private var selectedCellIndexPath: IndexPath?
    
    private let headerHeight: CGFloat = 20.0
    
    
    //MARK: - Open metods
    
    func getFilter() -> Filters {
        var filterItem: Filters
        filterItem = periodCellsType[selectedCellIndexPath!.row]
        return filterItem
    }
    
    func setStartFilter(_ filer: Filters) {
        guard let row = periodCellsType.firstIndex(of: filer)
            else { return }
        selectedCellIndexPath = IndexPath(row: row, section: 0)
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
