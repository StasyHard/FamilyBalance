
import Foundation
import RxSwift


protocol SingInViewModelProtocol: class {
    var repository: AppRepository { get set }
    
    var isSignInActiveObservable: Observable<Bool> { get set }
    var isLoadingObservable: Observable<Bool> { get set }
    var didSignInObservable: Observable<Void> { get set}
    var signUpTappedObservable: Observable<Void> { get set}
}

protocol SingInViewControllerActions: class {
    func signIn(_ email: String, _ password: String)
    func signUp()
}



final class SignInViewModel: SingInViewModelProtocol {
    
    //MARK: - Open properties
    var repository: AppRepository = AppRepository()
    
    var isSignInActiveObservable: Observable<Bool>
    var isLoadingObservable: Observable<Bool>
    var didSignInObservable: Observable<Void>
    var signUpTappedObservable: Observable<Void>
    
    //MARK: - Private properties
    private let isSignInActive = BehaviorSubject<Bool>(value: true)
    private let isLoading = BehaviorSubject<Bool>(value: false)
    private let didSignIn = PublishSubject<Void>()
    private let signUpTapped = PublishSubject<Void>()
    
    private let disposeBag = DisposeBag()
    
    //MARK: - Init
    init() {
        isSignInActiveObservable = isSignInActive
        isLoadingObservable = isLoading
        didSignInObservable = didSignIn
        signUpTappedObservable = signUpTapped
        
    }
}



extension SignInViewModel: SingInViewControllerActions {
    func signIn(_ email: String, _ password: String) {
        isSignInActive.onNext(false)
        isLoading.onNext(true)
        
        if email.isEmpty || password.isEmpty { return }
        
        let loginModel = LoginModel(email: email, password: password)
        repository.signgIn(loginModel)
            .subscribe(
                onSuccess: { [weak self] token in
                    print(token)
                    self?.didSignIn.onNext(())
                },
                onError: { error in
                    print(error)
                    _ = error
            })
            .disposed(by: self.disposeBag)
    }
    
    func signUp() {
        signUpTapped.onNext(())
    }
}
