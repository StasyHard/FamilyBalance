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


class SignInViewModel {
    
    let service = Service()
    
    let isSignInActive = BehaviorSubject<Bool>(value: true)
    let isLoading = BehaviorSubject<Bool>(value: false)
    let error = PublishSubject<SignInError>()
    
    private let disposeBag = DisposeBag()
    
    
    func signIn(_ email: String, _ password: String) {
        checkSignInErrors(email, password)
       
        if email.isEmpty || password.isEmpty { return }
        
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
    
    func checkSignInErrors(_ email: String, _ password: String) {
        if email.isEmpty {
            error.onNext(.emailIsEmptyError)
        }
        
        if password.isEmpty {
            error.onNext(.passwordIsEmptyError)
        }
    }
    
}
