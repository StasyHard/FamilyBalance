
import UIKit


protocol FiltersViewImplementation: class {
   func setProvider(provider: FiltersViewActions)
}


class FiltersView: UIView {

    @IBOutlet weak var filterTableView: UITableView!
    @IBOutlet weak var showButtonTapped: BlueRoundedButton!
    
}

extension FiltersView: FiltersViewImplementation {
    func setProvider(provider: FiltersViewActions) {
        
    }
    
    
}


