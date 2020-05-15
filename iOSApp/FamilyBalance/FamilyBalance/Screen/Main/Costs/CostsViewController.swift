
import UIKit
import RxSwift
import RxCocoa
import Charts

class CostsViewController: UIViewController {
    
    //MARK: - Open properties
    var viewModel: (CostsViewModelObservable & CostsViewControllerActions)?
    var navController: UINavigationController?
    
    
    //MARK: - Private properties
    private lazy var costsView = view as? CostsViewImplementation
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let filterButton = UIBarButtonItem(image: UIImage(named: "filter"), style: .done, target: self, action: #selector(filterButtonTapped))
        print(filterButton)
        //filterButton.tintColor = .clear
        navigationItem.rightBarButtonItem = filterButton
        
        observeViewModel()
        costsView?.setProvider(provider: self)
    }
    
    @objc func filterButtonTapped() {
        print("Tapped")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    //MARK: - Private metods
    
    //MARK: Observe on the ViewModel
    private func observeViewModel() {
        
    }
}



extension CostsViewController: CostsViewActions {
    
}
