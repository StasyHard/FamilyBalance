
import UIKit


extension UIViewController {
    func showAlertWithOneAction(title: String, message:String, actionTitle: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: actionTitle,
                                   style: .default,
                                   handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
