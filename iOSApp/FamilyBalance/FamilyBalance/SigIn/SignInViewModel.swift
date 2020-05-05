//
//  SignInViewModel.swift
//  FamilyBalance
//
//  Created by Anastasia Reyngardt on 02.05.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import Foundation
import RxSwift


enum SingInError {
    case emailIsEmptyError
    case passwordIsEmptyError
}

class SignInViewModel {
    
    let service = Servise()
    
    let email = BehaviorSubject<String>(value: "")
    let password = BehaviorSubject<String>(value: "")
    let isSignInActive = BehaviorSubject<Bool>(value: true)
    let isLoading = BehaviorSubject<Bool>(value: false)
    let error = PublishSubject<SingInError>()
    
    private let disposeBag = DisposeBag()
    
    
    func signIn() {
        Observable
            .combineLatest(email, password)
            .take(1)
            //            .do(onNext: { [weak self] (email, password) in
            //                if email.isEmpty {
            //                    self?.error.onNext(.emailIsEmptyError)
            //                }
            //                if password.isEmpty {
            //                    self?.error.onNext(.passwordIsEmptyError)
            //                }
            //            })
            .filter { !$0.isEmpty && !$1.isEmpty }
            .map { email, password in
                LoginModel(email: email, password: password)
        }
//        .flatMapLatest {
//            service.signgIn($0)
//        }
        .subscribe(
            onNext: { [weak self] _ in
                self?.isLoading.onNext(false)
            },
            onError: { [weak self] error in
                self?.isLoading.onNext(false)
        })
            .disposed(by: self.disposeBag)
        
//        self.isLoading.onNext(true)
//        self.isSignInActive.onNext(false)
    
        print("signIn")
    }
    
}
