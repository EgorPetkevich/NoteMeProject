//
//  RegisterPresenter.swift
//  NoteMe
//
//  Created by George Popkich on 14.11.23.
//

import UIKit

protocol RegisterAuthServiceUseCase {
    func register(email: String,
                  password: String?,
                  repeatPassword: String?,
                  complition: @escaping (Bool) -> Void)
}

protocol RegisterPresenterDelegate: AnyObject {
    func setEmailError(error: String?)
    func setPasswordError(error: String?)
    func setRepeatPassError(error: String?)
    
    func keyboardFrameChanged(_ frame: CGRect)
}

protocol KeyboardHelperUseCase {
    func onWillShow(_ handler: @escaping (CGRect) -> Void) -> Self
    func onWillHide(_ handler: @escaping (CGRect) -> Void) -> Self
    
}
protocol RegisterInputValidatorUseCase {
    func validate(email: String?) -> Bool
    func validate(password: String?) -> Bool
}


final class RegisterPresenter: RegisterPresenterProtocol {
   
    weak var delegate: RegisterPresenterDelegate?
    
    private let registerAuthService: RegisterAuthServiceUseCase
    private let keyboardHelper: KeyboardHelperUseCase
    private let inputValidator: RegisterInputValidatorUseCase
    
    init(keyboardHelper: KeyboardHelperUseCase,
         registerAuthService: RegisterAuthServiceUseCase,
         inputValidator: RegisterInputValidatorUseCase) {
        self.keyboardHelper = keyboardHelper
        self.registerAuthService = registerAuthService
        self.inputValidator = inputValidator
        
        bind()
    }
    
    private func bind() {
        keyboardHelper.onWillShow { [weak self] frame in
            self?.delegate?.keyboardFrameChanged(frame)
        }.onWillHide { [weak self] frame in
            self?.delegate?.keyboardFrameChanged(frame)
        }
    }
    
    func registerDidTap(email: String?, 
                        password: String?,
                        repeatPassword: String?) {
        guard
            checkValidation(email: email, 
                            password: password,
                            repeatPassword: repeatPassword),
            let email,
            let password,
            let repeatPassword
        else {return}
        
        registerAuthService.register(email: email,
                                     password: password,
                                     repeatPassword: repeatPassword)
        { isSuccess in
            print(isSuccess)
        }
        
    }
    
    func haveAccountDidTap() {
        
    }
    
        private func checkValidation(email: String?, 
                                     password: String?,
                                     repeatPassword: String?) -> Bool {
            let isEmailValid = inputValidator.validate(email: email)
            let isPasswordValid = inputValidator.validate(password: password)
            let isRepeatPassValid = repeatPassword == password
            
            delegate?.setEmailError(error: 
                                        isEmailValid ? nil : "Wrong Email")
            delegate?.setPasswordError(error: 
                                        isPasswordValid ? nil : "Non-Valid Password")
            delegate?.setRepeatPassError(error: 
                                        isRepeatPassValid ? nil : "Passwords do not match")
            
            return isEmailValid && isPasswordValid && isRepeatPassValid
        }
    
    
    
    
    
}
