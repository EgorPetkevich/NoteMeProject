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
    func catchEmailError(email: String?, password: String?, error: (String) -> Void) {
        
    }
    
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
    
    func loginDidTap(email: String?, password: String?) { 
        guard inputValidator.validate(email: email) else {
            catchEmailError?("Wrong E-mail")
            return
        }
        catchEmailError?(nil)
        guard inputValidator.validate(password: password) else {
            catchPasswordError?("Non-valid Password")
            return
        }
        catchPasswordError?(nil)
        guard let email, let password else {return}
        authService.login(email: email, password: password) { isSuccess in
            print(isSuccess)
        }
    }
    
    func newAccountDidTap() { }
    
    func forgotPasswordDidTap(email: String?) {}
    
}
