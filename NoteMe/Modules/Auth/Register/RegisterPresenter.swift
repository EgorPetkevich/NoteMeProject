//
//  RegisterPresenter.swift
//  NoteMe
//
//  Created by George Popkich on 14.11.23.
//

import UIKit

protocol RegisterCoordinatorProtocol: AnyObject {
    func finish()
    func showAlert(_ alert: UIAlertController)
}

protocol RegisterAuthServiceUseCaseProtocol {
    func register(email: String,
                  password: String,
                  repeatPassword: String,
                  complition: @escaping (Bool) -> Void)
}

protocol RegisterPresenterDelegate: AnyObject {
    func setEmailError(error: String?)
    func setPasswordError(error: String?)
    func setRepeatPassError(error: String?)
    
    func keyboardFrameChanged(_ frame: CGRect)
}

protocol KeyboardHelperRegisterUseCaseProtocol {
    @discardableResult
    func onWillShow(_ handler: @escaping (CGRect) -> Void) -> KeyboardHelper
    @discardableResult
    func onWillHide(_ handler: @escaping (CGRect) -> Void) -> KeyboardHelper
}

protocol RegisterInputValidatorUseCaseProtocol {
    func validate(email: String?) -> Bool
    func validate(password: String?) -> Bool
}

protocol RegisterAlertServiceUseCaseProtocol {
    func showRegisterAlert(title: String, message: String?, okTitle: String)
}

final class RegisterPresenter: RegisterPresenterProtocol {
   
    weak var delegate: RegisterPresenterDelegate?
    
    private weak var coordinator: RegisterCoordinatorProtocol?
    
    private let registerAuthService: RegisterAuthServiceUseCaseProtocol
    private let keyboardHelper: KeyboardHelperRegisterUseCaseProtocol
    private let inputValidator: RegisterInputValidatorUseCaseProtocol
    private let alertService: RegisterAlertServiceUseCaseProtocol
    
    init(keyboardHelper: KeyboardHelperRegisterUseCaseProtocol,
         registerAuthService: RegisterAuthServiceUseCaseProtocol,
         inputValidator: RegisterInputValidatorUseCaseProtocol,
         coordinator: RegisterCoordinatorProtocol,
         alertService: RegisterAlertServiceUseCaseProtocol) {
        self.keyboardHelper = keyboardHelper
        self.registerAuthService = registerAuthService
        self.inputValidator = inputValidator
        self.coordinator = coordinator
        self.alertService = alertService
        
        bind()
    }
    
    private func bind() {
        keyboardHelper.onWillShow { [weak self] in
            self?.delegate?.keyboardFrameChanged($0)
        }.onWillHide { [weak self] in
            self?.delegate?.keyboardFrameChanged($0)
        }
    }
    
    func registerDidTap(email: String?, 
                        password: String?,
                        repeatPassword: String?) {
        print("\(#function)")
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
        { [weak self] isSuccess in
            print(isSuccess)
            if isSuccess {
//                FIXME: uncomment
                self?.alertService.showRegisterAlert(
                    title: "Success Registation",
                    message: nil,
                    okTitle: "Ok")
                self?.coordinator?.finish()
            }else {
                self?.alertService.showRegisterAlert(
                    title: "Error",
                    message: "Invalid Email or Password",
                    okTitle: "Ok")
            
                self?.errorValidation()
            }
        }
        
    }
    
    func haveAccountDidTap() {
        print("\(#function)")
        coordinator?.finish()
    }
    
    private func setError() {
        
    }
    
    private func checkValidation(email: String?,
                                 password: String?,
                                 repeatPassword: String?) -> Bool {
        let isEmailValid = inputValidator.validate(email: email)
        let isPasswordValid = inputValidator.validate(password: password)
        let isRepeatPassValid = repeatPassword == password
        
        delegate?.setEmailError(error:
                                    isEmailValid ? nil : .Auth.registerEmailError)
        delegate?.setPasswordError(error:
                                    isPasswordValid ? nil : .Auth.registerPassError)
        delegate?.setRepeatPassError(error:
                                        isRepeatPassValid ? nil : .Auth.registerRepPassError)
        
        return isEmailValid && isPasswordValid && isRepeatPassValid
    }
    
    private func errorValidation(
        isEmailValid: Bool = false,
        isPasswordValid: Bool = false,
        isRepeatPassValid: Bool = false) {
            delegate?
                .setEmailError(error:
                                isEmailValid ? nil : .Auth.registerEmailError)
            delegate?
                .setPasswordError(error:
                                    isPasswordValid ? nil : .Auth.registerPassError)
            delegate?
                .setRepeatPassError(error:
                                        isRepeatPassValid ? nil : .Auth.registerRepPassError)
    }
      
}
