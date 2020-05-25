
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
        costsView?.setaAtionsDelegate(delegate: viewModel)
        observeViewModel(viewModel)
        
        viewModel.viewDidLoad()
    }
    
    
    //MARK: - Private metods
    private func setNavigationUI() {
        navigationItem.title = "Расходы"
        
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
    
    private func observeViewModel(_ viewModel: CostsViewModelObservable) {
        
        viewModel.categoryData
            .bind { [weak self] categories in
                self?.costsView?.setCategories(categories)
        }
        .disposed(by: self.disposeBag)
        
        viewModel.graphData
            .bind { [weak self] categories in
                self?.costsView?.setGraphCategories(categories)
        }
        .disposed(by: self.disposeBag)
        
        viewModel.incomeSum
            .bind { [weak self] sum in
                self?.costsView?.setIncomeSum(sum)
        }
        .disposed(by: self.disposeBag)
        
        viewModel.costsSum
            .bind { [weak self] sum in
                self?.costsView?.setCostsSum(sum)
            }
        .disposed(by: self.disposeBag)
    }
    
}




