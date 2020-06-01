
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
        configureDismissKeyboard()
        
        guard let viewModel = viewModel else { return }
        addOperationView?.setActionsDelegate(viewModel)
        observeViewModel(viewModel)
        
        viewModel.viewDidLoad()
    }
    
    
    //MARK: - Private metods
    private func setNavigationUI() {
        navigationItem.title = "Добавить"
        
//       let settingsImage = UIImage(named: "settings")?
//            .scaleTo(CGSize(width: AppSizes.iconHeightAndWidth,
//                            height: AppSizes.iconHeightAndWidth))
//        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
//            image: settingsImage,
//            style: .plain,
//            target: self,
//            action: #selector(settingsButtonTapped))
    }
    
//    @objc private func settingsButtonTapped() {
//        print("settingsButtonTapped")
//    }
    
    private func observeViewModel(_ viewModel: AddOperationViewModelObservable) {
        
        viewModel.defaultAccount
            .bind { [weak self] account in
                self?.addOperationView?.showDefaultAccount(account: account)
        }
        .disposed(by: self.disposeBag)
        
        viewModel.defaultCatecory
            .bind { [weak self] category in
                self?.addOperationView?.showDefaultCategory(category: category)
        }
        .disposed(by: self.disposeBag)
        
        viewModel.addOperationResponse
            .bind { response in
                switch response {
                case .sumIsNil:
                    self.showAlertWithOneAction(title: "Ошибка", message: "Введите сумму операции", actionTitle: "ОК")
                case .error:
                    self.showAlertWithOneAction(title: "Ошибка", message: "Сохраните операцию повторно", actionTitle: "ОК")
                case .success:
                    self.showAlertWithOneAction(title: "Операция сохранена", message: "", actionTitle: "ОК")
                    
                }
        }
        .disposed(by: self.disposeBag)
    }
}
