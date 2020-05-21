
import UIKit


protocol FiltersViewImplementation: class {
    func setActionsDelegate(delegate: FiltersViewActions)
}


class FiltersView: UIView {
    
    //MARK: - IBOutlet
    @IBOutlet weak var filterTableView: UITableView! {
        didSet {
        filterTableView.backgroundColor = AppColors.backgroundColor
        registerCells()
        filterTableView.delegate = tableViewProvider
        filterTableView.dataSource = tableViewProvider
    }
    }
    
    
    //MARK: - Private properties
    private var actionsDelegate: FiltersViewActions?
    //TODO: ------------------------------- Подумать где должна быть реализация
    private let tableViewProvider = FiltersTableViewProvider()
    
    
    //MARK: - IBAction
    @IBAction func showButtonIsTapped(_ sender: BlueRoundedButton) {
        let filter = tableViewProvider.getFilter()
        actionsDelegate?.showButtonTapped(filter: filter)
    }
    
    
    private func registerCells() {
        //TODO: - написать кастомные ячейки и зарегистрировать их
    }
    
}



extension FiltersView: FiltersViewImplementation {
    func setActionsDelegate(delegate: FiltersViewActions) {
        self.actionsDelegate = delegate
    }
}


