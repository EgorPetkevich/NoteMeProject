//
//  LoginVM.swift
//  NoteMe
//
//  Created by George Popkich on 10.11.23.
//

import Foundation

protocol LoginAuthServiceUseCase {
    func login(email: String,
               password: String,
               completion: @escaping (Bool) -> Void)
}

protocol LoginInputValidatorUseCase {
    func validate(email: String?) -> Bool
    func validate(password: String?) -> Bool
}

final class LoginVM: LoginViewModelProtocol {
        
    var catchEmailError: ((String?) -> Void)?
    var catchPasswordError: ((String?) -> Void)?
    
    private let authService: LoginAuthServiceUseCase
    private let inputValidator: LoginInputValidatorUseCase
    
    
    init(authService: LoginAuthServiceUseCase,
         inputValidator: LoginInputValidatorUseCase
    ) {
        self.inputValidator = inputValidator
        self.authService = authService
    }
    
    func loginDidTap(email: String?, password: String?)  {
        guard
            checkValidation(email: email, password: password),
            let email,
            let password
        else {return}
        
        authService.login(email: email, password: password) { isSuccess in
            print(isSuccess)
            
        }
    }
    
    func newAccountDidTap() { }
    
    func forgotPasswordDidTap(email: String?) { }
    
    private func checkValidation(email: String?, password: String?) -> Bool {
        let isEmailValid = inputValidator.validate(email: email)
        let isPasswordValid = inputValidator.validate(password: password)
        
        catchEmailError?(isEmailValid ? nil : "Wrong Email")
        catchPasswordError?(isPasswordValid ? nil : "Non-Valid Password")
        
        return isEmailValid && isPasswordValid
    }
    
}
