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
    
    
    //MARK: - Open properties
    var viewModel: SignInViewModel?
    
    //MARK: - IBOutlet
    @IBOutlet private weak var emailTextField: BlueStrokeTextField!
    @IBOutlet private weak var passwordTextField: BlueStrokeTextField!
    @IBOutlet private weak var logInButton: UIButton!

    //MARK: - Private properties
    private let disposeBag = DisposeBag()
    
    
    //MARK: - IBAction
    @IBAction private func signInTapped(_ sender: UIButton) {
        if let emailInput = emailTextField.text, emailInput.isEmpty {
            showTextFieldError(emailTextField)
        }
        if let passwordInput = passwordTextField.text, passwordInput.isEmpty {
            showTextFieldError(passwordTextField)
        }
        else {
            viewModel?.signIn(emailTextField.text!, passwordTextField.text!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //-------------------------------------------------------------временно
        navigationController?.navigationBar.isHidden = true
        viewModel = SignInViewModel()
        
        setupViews()
        observeViewModel()
    }

    private func setupViews() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func observeViewModel() {
        guard let viewModel = self.viewModel else { return }
        viewModel.isSignInActive
            .bind { [weak self] in self?.handlerIsSignInActive(isActive: $0) }
            .disposed(by: self.disposeBag)
        
        viewModel.isLoading
            .filter { $0 }
            .bind { [weak self] _ in self?.showProgressView() }
            .disposed(by: self.disposeBag)
    }
    
    private func handlerIsSignInActive(isActive: Bool) {
        self.logInButton.isEnabled = isActive
        self.emailTextField.isEnabled = isActive
        self.passwordTextField.isEnabled = isActive
    }
    
    private func showProgressView() {
        print("showProgressView")
    }
    
    private func showTextFieldError(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.red.cgColor
    }
    
}

//MARK: - UITextFieldDelegate
extension SignInViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let textInput = textField.text, textInput.isEmpty {
            showTextFieldError(textField)
        }
    }
    
    //Вызывается каждый раз при изменении текста, а нужно чтоб только при начале редактирования
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if  textField.layer.borderColor == UIColor.red.cgColor {
            textField.layer.borderColor = UIColor.blue.cgColor
        }
    }
    
    
    
}

