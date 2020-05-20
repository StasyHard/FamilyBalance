
import UIKit
import RxSwift
import RxCocoa
import Charts

class CostsViewController: UIViewController {
    
    //MARK: - Open properties
    var viewModel: (CostsViewModelObservable & CostsViewActions)?
    
    
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
        
        viewModel.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    //MARK: - Private metods
    private func setNavigationUI() {
        title = "Расходы"
        let defaultImage = UIImage(named: "filter")?
            .scaleTo(CGSize(width: AppSizes.iconHeightAndWidth,
                            height: AppSizes.iconHeightAndWidth))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: defaultImage,
            style: .plain,
            target: self,
            action: #selector(filterButtonTapped))
    }
    
    @objc private func filterButtonTapped() {
        viewModel?.filtersDidTapped()
    }
    
    
    //MARK: - Private metods
    
    //MARK: Observe on the ViewModel
    private func observeViewModel(_ viewModel: CostsViewModelObservable) {
        
        viewModel.categoryData
            .bind { [weak self] data in
                self?.costsView?.setData(data)
        }
        .disposed(by: self.disposeBag)
    }
}




