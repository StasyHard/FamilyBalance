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
        
        //-------------------------------------------------------------временно
        navigationController?.navigationBar.isHidden = true
        viewModel = SignInViewModel()
        
        setUpBindings()
        setUpCallbacks()
    }
    
    private func setUpBindings() {
        guard let viewModel = self.viewModel else { return }
     
        emailTextField.rx.text.orEmpty
            .bind(to: viewModel.email)
            .disposed(by: self.disposeBag)
        
        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: self.disposeBag)
        
        
        logInButton.rx.tap
            .bind { [weak self] in self?.viewModel?.signIn() }
            .disposed(by: self.disposeBag)
        
    }
    
    private func setUpCallbacks() {
        guard let viewModel = self.viewModel else { return }
        
        viewModel.isSignInActive
            .bind { [weak self] in self?.handleIsSignInActive(isActive: $0) }
            .disposed(by: self.disposeBag)
        
        viewModel.isLoading
            .filter { $0 }
            .bind { [weak self] _ in self?.showProgressView() }
            .disposed(by: self.disposeBag)
    }
    
    private func handleIsSignInActive(isActive: Bool) {
        self.logInButton.isEnabled = isActive
        self.emailTextField.isEnabled = isActive
        self.passwordTextField.isEnabled = isActive
    }
    
    private func showProgressView() {
        print("showProgressView")
    }
}

