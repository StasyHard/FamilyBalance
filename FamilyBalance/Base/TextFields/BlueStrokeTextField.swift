
import UIKit


class BlueStrokeTextField: UITextField {
    
    //MARK: - Private metods
    private var error = false
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    
    //MARK: - Open metods
    func textChanged(){
        if error == true {
            layer.borderColor = AppColors.primaryColor.cgColor
            error = false
        }
    }
    
    func showError() {
        error = true
        layer.borderColor = AppColors.textFieldErrorBorderColor.cgColor
    }
    
    
    //MARK: - Private metods
    private func setupUI() {
        layer.borderWidth = AppSizes.stdViewBorderWidth
        layer.borderColor = AppColors.primaryColor.cgColor
        layer.cornerRadius = 5
        clipsToBounds = true
    }
}
