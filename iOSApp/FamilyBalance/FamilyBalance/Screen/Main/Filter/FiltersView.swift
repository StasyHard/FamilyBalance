
import UIKit


protocol FiltersViewImplementation: class {
    func setProvider(provider: FiltersViewActions)
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
    private var provider: FiltersViewActions?
    //TODO: ------------------------------- Подумать где должна быть реализация
    private let tableViewProvider = FiltersTableViewProvider()
    
    //MARK: - IBAction
    @IBAction func showButtonIsTapped(_ sender: BlueRoundedButton) {
        //Получить от tableViewProvider фильтр
        
    }
    
    
    private func registerCells() {
        //TODO: - написать кастомные ячейки и зарегистрировать их
    }
    
}



extension FiltersView: FiltersViewImplementation {
    func setProvider(provider: FiltersViewActions) {
        self.provider = provider
    }
    
    
}


