
import UIKit

class CategoryCell: UITableViewCell, ReusableView {
    
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var backgroundColorView: UIView!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    
    override func awakeFromNib() {
        backgroundColor = AppColors.backgroundColor
    }
    
    override func layoutSubviews() {
        colorView.layer.cornerRadius = 12
        colorView.clipsToBounds = true
        
        backgroundColorView.layer.cornerRadius = 10
        backgroundColorView.clipsToBounds = true
    }
    
}
