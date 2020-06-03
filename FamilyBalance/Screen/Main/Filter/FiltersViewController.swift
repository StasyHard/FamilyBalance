
import UIKit
import RxSwift
import RxCocoa


class FiltersViewController: UIViewController {
    
    //MARK: - Open properties
    var viewModel: (FiltersViewModelObservable & FiltersViewActions)?
    
    
    //MARK: - Private properties
    private lazy var filtersView = view as? FiltersViewImplementation
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationUI()
        
        guard let viewModel = viewModel else { return }
        filtersView?.setActionsDelegate(delegate: viewModel)
        observeViewModel(viewModel)
    }
    
    private func setNavigationUI() {
        title = "Фильтры"
        
        let defaultImage = UIImage(named: "close")?
            .scaleTo(CGSize(width: 15,
                            height: 15))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: defaultImage,
            style: .plain,
            target: self,
            action: #selector(closeButtonTapped))
    }
    
    @objc private func closeButtonTapped() {
        viewModel?.closeButtonDidTapped()
    }
    
    private func observeViewModel(_ viewModel: FiltersViewModelObservable) {
        
        viewModel.startFilter
            .bind { [weak self] filter in
                self?.filtersView?.setStartFilter(filter)
        }
        .disposed(by: self.disposeBag)
    }
}
