
import UIKit

class AuthBackView: UIView {
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    
    //MARK: - Private metods
    private func setupUI() {
        backgroundColor = AppColors.backgroundColor
        layer.cornerRadius = 10
        layer.borderWidth = AppSizes.stdViewBorderWidth
        layer.borderColor =  AppColors.primaryColor.cgColor
        addShadow()
    }
    
    private func addShadow() {
        layer.shadowColor = AppColors.primaryColor.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        layer.shadowRadius = 4.0
    }
}
