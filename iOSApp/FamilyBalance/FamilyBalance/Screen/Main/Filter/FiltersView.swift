
import UIKit


protocol FiltersViewImplementation: class {
    func setProvider(provider: FiltersViewActions)
}


class FiltersView: UIView {
    
    //MARK: - IBOutlet
    @IBOutlet weak var filterTableView: UITableView!
    
    //MARK: - Private properties
    
    
    //MARK: - IBAction
    @IBAction func showButtonIsTapped(_ sender: BlueRoundedButton) {
    }
    
}

extension FiltersView: FiltersViewImplementation {
    func setProvider(provider: FiltersViewActions) {
        
    }
    
    
}


