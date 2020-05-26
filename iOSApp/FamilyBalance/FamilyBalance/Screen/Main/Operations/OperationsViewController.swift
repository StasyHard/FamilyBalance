
import UIKit
import RxSwift
import RxCocoa

class OperationsViewController: UIViewController {
    
    //MARK: - Open properties
    var viewModel: (OperationsViewModelObservable & OperationsViewActions)?
    
    
    //MARK: - Private properties
    private lazy var operationsView = view as? OperationsViewImplementation
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationUI()
        
        guard let viewModel = viewModel else { return }
        operationsView?.setActionsDelegate(delegate: viewModel)
        observeViewModel(viewModel)
        
        viewModel.viewDidLoad()
    }
    
    
    //MARK: - Private metods
    private func setNavigationUI() {
        navigationItem.title = "Операции"
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
        //viewModel?.filtersDidTapped()
    }
    
    private func observeViewModel(_ viewModel: OperationsViewModelObservable) {
        
    }
}

