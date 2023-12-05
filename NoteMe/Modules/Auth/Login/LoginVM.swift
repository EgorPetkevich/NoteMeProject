//
//  LoginVM.swift
//  NoteMe
//
//  Created by George Popkich on 10.11.23.
//

import Foundation

protocol LoginCoordinatorProtocol: AnyObject {
    func finish()
    func openRegisterModule()
    func openResetModule()
}

protocol LoginAuthServiceUseCase {
    func login(email: String,
               password: String,
               completion: @escaping (Bool) -> Void)
}

protocol LoginInputValidatorUseCase {
    func validate(email: String?) -> Bool
    func validate(password: String?) -> Bool
}

protocol KeyboardHelperLoginUseCase {
    @discardableResult
    func onWillShow(_ handler: @escaping (CGRect) -> Void) -> Self
    @discardableResult
    func onWillHide(_ handler: @escaping (CGRect) -> Void) -> Self
}


final class LoginVM: LoginViewModelProtocol {
    
    var keyboardFrameChanged: ((CGRect) -> Void)?
    var catchEmailError: ((String?) -> Void)?
    var catchPasswordError: ((String?) -> Void)?
    
    private weak var coordinator: LoginCoordinatorProtocol?
    
    private let keyboardHelper: KeyboardHelperLoginUseCase
    private let authService: LoginAuthServiceUseCase
    private let inputValidator: LoginInputValidatorUseCase
    
    init(authService: LoginAuthServiceUseCase,
         inputValidator: LoginInputValidatorUseCase,
         coordinator: LoginCoordinatorProtocol,
         keyboardHelper: KeyboardHelperLoginUseCase ) {
        self.inputValidator = inputValidator
        self.authService = authService
        self.coordinator = coordinator
        self.keyboardHelper = keyboardHelper
        
        bind()
    }
    
    private func bind() {
        keyboardHelper.onWillShow { [weak self] frame in
            self?.keyboardFrameChanged?(frame)
        }.onWillHide { [weak self] frame in
            self?.keyboardFrameChanged?(frame)
        }
    }
    
    func loginDidTap(email: String?, password: String?)  {
        print("\(#function)")
        guard
            checkValidation(email: email, password: password),
            let email,
            let password
        else {return}
        
        authService.login(email: email, password: password) { [weak coordinator]
            isSuccess in
                print(isSuccess)
            if isSuccess {
                ParametersHelper.set(.authenticatied, value: true)
                coordinator?.finish()
            }
            
        }
    }
    
    func newAccountDidTap() {
        print("\(#function)")
        coordinator?.openRegisterModule()
    }
    
    func forgotPasswordDidTap(email: String?) { 
        print("\(#function)")
        coordinator?.openResetModule()
    }
    
    private func checkValidation(email: String?, password: String?) -> Bool {
        let isEmailValid = inputValidator.validate(email: email)
        let isPasswordValid = inputValidator.validate(password: password)
        
        catchEmailError?(isEmailValid ? nil : .Auth.loginEmailError)
        catchPasswordError?(isPasswordValid ? nil : .Auth.loginPassError)
        
        return isEmailValid && isPasswordValid
    }
    
}
