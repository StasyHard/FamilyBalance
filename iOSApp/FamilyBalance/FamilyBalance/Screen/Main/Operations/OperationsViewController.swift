
import UIKit
import RxSwift
import RxCocoa

class OperationsViewController: UIViewController {
    
    //MARK: - Open properties
    var viewModel: (OperationsViewControllerActions & OperationsViewModelObservable)?
    
    
    //MARK: - Private properties
    private lazy var operationsView = view as? OperationsViewImplementation
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationUI()
        
        observeViewModel()
        operationsView?.setActionsDelegate(delegate: self)
    }
    
    
    //MARK: - Private metods
    private func setNavigationUI() {
        title = "Операции"
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
    
    private func observeViewModel() {
        
    }
}



extension OperationsViewController: OperationsViewActions {
    
}

