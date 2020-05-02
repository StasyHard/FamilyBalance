//
//  SignInViewController.swift
//  FamilyBalance
//
//  Created by Anastasia Reyngardt on 29.04.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SignInViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    //MARK: - Open properties
    var viewModel: SignInViewModel?
    
    //MARK: - Private properties
    private let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}

