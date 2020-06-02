
import UIKit


class BlueRoundedButton: UIButton {
    
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
        tintColor = .white
        backgroundColor = AppColors.primaryColor
        layer.cornerRadius = 5
    }
}
