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

protocol RegisterAuthServiceUseCase {
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

protocol KeyboardHelperRegisterUseCase {
    @discardableResult
    func onWillShow(_ handler: @escaping (CGRect) -> Void) -> Self
    @discardableResult
    func onWillHide(_ handler: @escaping (CGRect) -> Void) -> Self
}

protocol RegisterInputValidatorUseCase {
    func validate(email: String?) -> Bool
    func validate(password: String?) -> Bool
}

final class RegisterPresenter: RegisterPresenterProtocol {
   
    weak var delegate: RegisterPresenterDelegate?
    
    private weak var coordinator: RegisterCoordinatorProtocol?
    
    private let registerAuthService: RegisterAuthServiceUseCase
    private let keyboardHelper: KeyboardHelperRegisterUseCase
    private let inputValidator: RegisterInputValidatorUseCase
    
    init(keyboardHelper: KeyboardHelperRegisterUseCase,
         registerAuthService: RegisterAuthServiceUseCase,
         inputValidator: RegisterInputValidatorUseCase,
         coordinator: RegisterCoordinatorProtocol) {
        self.keyboardHelper = keyboardHelper
        self.registerAuthService = registerAuthService
        self.inputValidator = inputValidator
        self.coordinator = coordinator
        
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
        { [self] isSuccess in
            print(isSuccess)
            if isSuccess {
//                FIXME: uncomment
                let alertVC = AlertBuilder.build(title: "Success Registation", message: nil)
//                coordinator?.showAlert(alertVC)
                coordinator?.finish()
            }else {
                let alertVC = AlertBuilder.build(title: "Error", message: "Invalid Email or Password", okTitle: "Ok")
                coordinator?.showAlert(alertVC)
                errorValidation()
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
