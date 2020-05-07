//
//  SignInViewModel.swift
//  FamilyBalance
//
//  Created by Anastasia Reyngardt on 02.05.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import Foundation
import RxSwift

enum SignInError {
    case emailIsEmptyError
    case passwordIsEmptyError
}

//Protocol - servise, signIn


final class SignInViewModel {
    
    //MARK: - Open properties
    let service = Service()
    
    let isSignInActiveObservable: Observable<Bool>
    let isLoadingObservable: Observable<Bool>
    
    //MARK: - Private properties
    private let isSignInActive = BehaviorSubject<Bool>(value: true)
    private let isLoading = BehaviorSubject<Bool>(value: false)
    
    private let disposeBag = DisposeBag()
    
        //MARK: - Init
    init() {
        isSignInActiveObservable = isSignInActive
        isLoadingObservable = isLoading
    }
    
    func signIn(_ email: String, _ password: String) {
        if email.isEmpty || password.isEmpty { return }
        
        isSignInActive.onNext(false)
        isLoading.onNext(true)
        
        service.signgIn(LoginModel(email: email, password: password))
            .subscribe(
                onNext: { [weak self] result in
                    self?.isLoading.onNext(false)
                },
                onError: { [weak self] error in
                    self?.isLoading.onNext(false)
            })
            .disposed(by: self.disposeBag)
    }
    
    
}
