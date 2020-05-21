
import UIKit
import RxSwift
import RxCocoa
import Charts


final class AddOperationViewController: UIViewController {
    
    //MARK: - Open properties
    var viewModel: (AddOperationViewModelObservable & AddOperationViewActions)?
    
    
    //MARK: - Private properties
    private lazy var addOperationView = view as? AddOperationViewImplementation
    
    private let disposeBag = DisposeBag()
    
    
     //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationUI()
        
        guard let viewModel = viewModel else { return }
        addOperationView?.setActionsDelegate(viewModel)
        observeViewModel(viewModel)
    }
    
    
    //MARK: - Private metods
    private func setNavigationUI() {
        navigationItem.title = "Добавить"
    }
    
    private func observeViewModel(_ viewModel: AddOperationViewModelObservable) {
    }

}
