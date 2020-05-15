
import UIKit
import RxSwift
import RxCocoa
import Charts

class CostsViewController: UIViewController {
    
    //MARK: - Open properties
    var viewModel: (CostsViewModelActions & CostsViewActions)?
    var navController: UINavigationController?
    
    
    //MARK: - Private properties
    private lazy var costsView = view as? CostsViewImplementation
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationUI()
        
        guard let viewModel = viewModel else { return }
        costsView?.setProvider(provider: viewModel)
        observeViewModel(viewModel)
    }
    
    private func setNavigationUI() {
        title = "Расходы"
        let defaultImage = UIImage(named: "filter")?
            .scaleTo(CGSize(width: 25, height: 25))

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: defaultImage,
            style: .plain,
            target: self,
            action: #selector(filterButtonTapped))
    }
    
    @objc func filterButtonTapped() {
        viewModel?.filterDidTapped()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    //MARK: - Private metods
    
    //MARK: Observe on the ViewModel
    private func observeViewModel(_ viewModel: CostsViewModelActions) {
        
    }
}




