
import UIKit


class AddOperationCell: UITableViewCell, ReusableView {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        print("Cell button tapped")
    }
}
