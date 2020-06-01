
import UIKit


protocol AddOperationCellDelegate: class {
    func buttonInCellTapped(_ cell: AddOperationCell)
}

final class AddOperationCell: UITableViewCell, ReusableView {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    weak var delegate: AddOperationCellDelegate?
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        delegate?.buttonInCellTapped(self)
    }
}
