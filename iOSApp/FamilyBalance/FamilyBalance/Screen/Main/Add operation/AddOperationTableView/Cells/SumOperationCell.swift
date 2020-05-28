import UIKit


final class SumOperationCell: UITableViewCell, ReusableView {

    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var summTextField: UITextField! {
        didSet {
            summTextField.delegate = self
        }
    }
}



//MARK: - UITextFieldDelegate
extension SumOperationCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let inputText = textField.text ?? ""
        if !inputText.isEmpty {
            textField.text = "\(inputText) ₽"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.endEditing(true)
        return true
    }
}
