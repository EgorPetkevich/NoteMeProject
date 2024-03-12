//
//  LoginVM.swift
//  NoteMe
//
//  Created by George Popkich on 10.11.23.
//
import UIKit

protocol LoginCoordinatorProtocol: AnyObject {
    func finish()
    func openRegisterModule()
    func openResetModule()
}

protocol LoginAuthServiceUseCaseProtocol {
    func login(email: String,
               password: String,
               completion: @escaping (Bool) -> Void)
}

protocol LoginInputValidatorUseCaseProtocol {
    func validate(email: String?) -> Bool
    func validate(password: String?) -> Bool
}

protocol KeyboardHelperLoginUseCaseProtocol {
    @discardableResult
    func onWillShow(_ handler: @escaping (CGRect) -> Void) -> KeyboardHelper
    @discardableResult
    func onWillHide(_ handler: @escaping (CGRect) -> Void) -> KeyboardHelper
}

protocol LoginAlertServiceUseCaseProtocol {
    func showLogAlert(title: String, message: String?, okTitle: String)
}


final class LoginVM: LoginViewModelProtocol {
    
    var keyboardFrameChanged: ((CGRect) -> Void)?
    var catchEmailError: ((String?) -> Void)?
    var catchPasswordError: ((String?) -> Void)?
    
    private weak var coordinator: LoginCoordinatorProtocol?
    
    private let keyboardHelper: KeyboardHelperLoginUseCaseProtocol
    private let authService: LoginAuthServiceUseCaseProtocol
    private let inputValidator: LoginInputValidatorUseCaseProtocol
    private let alertService: LoginAlertServiceUseCase
    
    init(authService: LoginAuthServiceUseCaseProtocol,
         inputValidator: LoginInputValidatorUseCaseProtocol,
         coordinator: LoginCoordinatorProtocol,
         keyboardHelper: KeyboardHelperLoginUseCaseProtocol,
         alertService: LoginAlertServiceUseCase) {
        self.inputValidator = inputValidator
        self.authService = authService
        self.coordinator = coordinator
        self.keyboardHelper = keyboardHelper
        self.alertService = alertService
        
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
            let email,
            let password
        else {return}
        
        authService.login(email: email, password: password) { [weak self]
            isSuccess in
            print(isSuccess)
            if isSuccess {
                //FIXME: uncomment
                self?.alertService.showLogAlert(
                    title: "Login Success",
                    message: nil,
                    okTitle: "Ok")
                ParametersHelper.set(.authenticatied, value: true)
                self?.coordinator?.finish()
            }else {
                self?.alertService.showLogAlert(
                    title: "Error",
                    message: "Invalid Email or Password",
                    okTitle: "Ok")
                
                
                self?.errorValidation()
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
        
        errorValidation(isEmailValid: isEmailValid, isPasswordValid: isPasswordValid)
        
        return isEmailValid && isPasswordValid
    }
    
    private func errorValidation(isEmailValid: Bool = false,
                                 isPasswordValid: Bool = false) {
        catchEmailError?(isEmailValid ? nil : .Auth.loginEmailError)
        catchPasswordError?(isPasswordValid ? nil : .Auth.loginPassError)
    }
    
}
