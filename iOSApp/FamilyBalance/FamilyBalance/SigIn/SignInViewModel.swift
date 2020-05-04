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
            .do(onNext: { [weak self] (email, password) in
                if email.isEmpty {
                    self?.error.onNext(.emailIsEmptyError)
                }
                if password.isEmpty {
                    self?.error.onNext(.passwordIsEmptyError)
                }
            })
            .filter { !$0.isEmpty && !$1.isEmpty }
//            .flatMapLatest { email, password in
//                print(email)
//                print(password)
//                Observable.of(1)
//                //service.signgIn(email, password)
//        }
       .subscribe {

        }
        


//            .subscribe (
//                {
//
//                    self.isLoading.onNext(false)
//                    //TODO сохранить токен и перейти на следующий экран
//            },
//                {
//                    self.isLoading.onNext(false)
//                    self.isSignInActive.onNext(true)
//                    //TODO обработать ошибку
//            })
        self.isLoading.onNext(true)
        self.isSignInActive.onNext(false)
        
        
        print("signIn")
    }
    
}
