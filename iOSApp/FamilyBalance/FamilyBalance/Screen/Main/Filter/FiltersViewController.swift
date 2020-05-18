
import UIKit


class FiltersViewController: UIViewController {
    
    //MARK: - Open properties
    //var viewModel: (CostsViewModelActions & CostsViewActions)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationUI()
    }

    private func setNavigationUI() {
        title = "Фильтры"
        
        let defaultImage = UIImage(named: "close")?
            .scaleTo(CGSize(width: AppSizes.iconHeightAndWidth,
                            height: AppSizes.iconHeightAndWidth))

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: defaultImage,
            style: .plain,
            target: self,
            action: #selector(closeButtonTapped))
    }
    
    @objc func closeButtonTapped() {
        
    }
}
