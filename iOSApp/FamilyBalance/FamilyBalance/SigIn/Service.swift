//
//  Servise.swift
//  FamilyBalance
//
//  Created by Anastasia Reyngardt on 04.05.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import Foundation
import RxSwift

class Service {
    
    func signgIn(_ loginModel: LoginModel) -> Observable<LoginModel> {
        return Observable.of(loginModel)
    }
    
}
