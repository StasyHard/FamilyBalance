//
//  SignInViewModel.swift
//  FamilyBalance
//
//  Created by Anastasia Reyngardt on 02.05.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import Foundation
import RxSwift

protocol SingInViewModelProtocol {
    var servise: Service { get set }
    var isSignInActiveObservable: Observable<Bool> { get set }
    var isLoadingObservable: Observable<Bool> { get set }
    var didSignInObservable: Observable<Void> { get set}
    var signUpTappedObservable: Observable<Void> { get set}
    
    func signIn(_ email: String, _ password: String)
    func signUp()
}

//Protocol - servise, signIn


final class SignInViewModel: SingInViewModelProtocol {
    
    //MARK: - Open properties
    var servise: Service = Service()
    
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
    
        //MARK: - Open metods
    func signIn(_ email: String, _ password: String) {
        isSignInActive.onNext(false)
        isLoading.onNext(true)
        
        didSignIn.onNext(())
        
        if email.isEmpty || password.isEmpty { return }
        
        servise.signgIn(LoginModel(email: email, password: password))
            .subscribe(
                onNext: { [weak self] result in
                    self?.isLoading.onNext(false)
                },
                onError: { [weak self] error in
                    self?.isLoading.onNext(false)
            })
            .disposed(by: self.disposeBag)
    }
    
    func signUp() {
        signUpTapped.onNext(())
    }
    
    
}
