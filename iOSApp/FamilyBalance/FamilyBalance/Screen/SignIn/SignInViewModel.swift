
import Foundation
import RxSwift


protocol SignInViewModelObservable: class {
    var isSignInActive: Observable<Bool> { get set }
    var isLoading: Observable<Bool> { get set }
    var didSignIn: Observable<Void> { get set}
    var signUpTapped: Observable<Void> { get set}
}

protocol SignInViewActions: class {
    func signInDidTapped(_ email: String, _ password: String)
    func signUpDidTapped()
}


final class SignInViewModel: SignInViewModelObservable {
    
    //MARK: - SignInViewModelActions
    var isSignInActive: Observable<Bool>
    var isLoading: Observable<Bool>
    var didSignIn: Observable<Void>
    var signUpTapped: Observable<Void>
    
    
    //MARK: - Private properties
    private let _isSignInActive = BehaviorSubject<Bool>(value: true)
    private let _isLoading = BehaviorSubject<Bool>(value: false)
    private let _didSignIn = PublishSubject<Void>()
    private let _signUpTapped = PublishSubject<Void>()
    
    private let repository: Repository
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Init
    init(repo: Repository) {
        self.repository = repo
        
        isSignInActive = _isSignInActive
        isLoading = _isLoading
        didSignIn = _didSignIn
        signUpTapped = _signUpTapped
        
    }
}



extension SignInViewModel: SignInViewActions {
    func signInDidTapped(_ email: String, _ password: String) {
        _isLoading.onNext(true)
        _isSignInActive.onNext(false)
        
        
        if email.isEmpty || password.isEmpty { return }
        
        let loginModel = LoginModel(email: email, password: password)
        repository.signIn(loginModel)
            .subscribe(
                onSuccess: { [weak self] token in
                    print(token)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                        self?._didSignIn.onNext(())
                    }
                    //self?.didSignIn.onNext(())
                },
                onError: { error in
                    print(error)
                    _ = error
            })
            .disposed(by: self.disposeBag)
    }
    
    func signUpDidTapped() {
        _signUpTapped.onNext(())
    }
}
