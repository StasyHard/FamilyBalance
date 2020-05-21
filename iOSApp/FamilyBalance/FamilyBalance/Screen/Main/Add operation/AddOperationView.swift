
import UIKit

protocol AddOperationViewImplementation: class {
    func setActionsDelegate(_ delegate: AddOperationViewActions)
    func setData()
}


final class AddOperationView: UIView {
    
    @IBOutlet weak var incomeOrCostsControl: UISegmentedControl!
    @IBOutlet weak var addOperationTableView: UITableView!
    @IBAction func saveButtonTapped(_ sender: BlueRoundedButton) {
    }
    
    //MARK: - Private properties
    private var actionsDelegate: AddOperationViewActions?
    private let tableViewProvider = AddOperationTableViewProvider()
    


}



extension AddOperationView: AddOperationViewImplementation {
    func setActionsDelegate(_ delegate: AddOperationViewActions) {
        self.actionsDelegate = delegate
    }
    
    func setData() {
        
    }
    
    
}
