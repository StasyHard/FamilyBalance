import UIKit


final class SumOperationCell: UITableViewCell, ReusableView {

    //MARK: - IBOutlet
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var summTextField: UITextField!
    
    weak var textFieldDelegate: UITextFieldDelegate? {
        didSet {
            summTextField.delegate = textFieldDelegate
        }
    }
    
    
    
        //MARK: - Open metods
    func getSum() -> Double? {
        return Double(summTextField.text!)
    }
}
