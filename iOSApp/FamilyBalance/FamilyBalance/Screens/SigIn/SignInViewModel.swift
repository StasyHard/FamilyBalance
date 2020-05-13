
import Foundation
import RxSwift


protocol SignInViewModelObservable: class {
    var isSignInActiveObservable: Observable<Bool> { get set }
    var isLoadingObservable: Observable<Bool> { get set }
    var didSignInObservable: Observable<Void> { get set}
    var signUpTappedObservable: Observable<Void> { get set}
}

protocol SignInViewControllerActions: class {
    func signIn(_ email: String, _ password: String)
    func signUp()
}



final class SignInViewModel: SignInViewModelObservable {
    
    //MARK: - Open properties
    private let repository: Repository
    
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
    init(repo: Repository) {
        self.repository = repo
        
        isSignInActiveObservable = isSignInActive
        isLoadingObservable = isLoading
        didSignInObservable = didSignIn
        signUpTappedObservable = signUpTapped
        
    }
}



extension SignInViewModel: SignInViewControllerActions {
    func signIn(_ email: String, _ password: String) {
        isSignInActive.onNext(false)
        isLoading.onNext(true)
        
        if email.isEmpty || password.isEmpty { return }
        
        let loginModel = LoginModel(email: email, password: password)
        repository.signIn(loginModel)
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
