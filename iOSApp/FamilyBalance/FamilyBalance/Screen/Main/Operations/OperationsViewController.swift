
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
        
        observeViewModel()
        operationsView?.setProvider(provider: self)
    }
    
    
    //MARK: - Private metods
    private func observeViewModel() {
        
    }
}



extension OperationsViewController: OperationsViewActions {
    
}

