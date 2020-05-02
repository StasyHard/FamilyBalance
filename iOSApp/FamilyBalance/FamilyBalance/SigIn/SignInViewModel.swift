//
//  SignInViewModel.swift
//  FamilyBalance
//
//  Created by Anastasia Reyngardt on 02.05.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import Foundation
import RxSwift

class SignInViewModel {
    
    let email = BehaviorSubject(value: "")
    let password = BehaviorSubject(value: "")
    let isSignInActive = BehaviorSubject<Bool>(value: false)
    let isLoading = BehaviorSubject<Bool>(value: false)
    
    private let disposeBag = DisposeBag()
    
}
