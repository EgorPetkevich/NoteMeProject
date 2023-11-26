//
//  RegisterPresenter.swift
//  NoteMe
//
//  Created by George Popkich on 14.11.23.
//

import UIKit

protocol RegisterCoordinatorProtocol: AnyObject {
    func finish()
}

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
        keyboardHelper.onWillShow { [weak self] frame in
            self?.delegate?.keyboardFrameChanged(frame)
        }.onWillHide { [weak self] frame in
            self?.delegate?.keyboardFrameChanged(frame)
        }
        
//        keyboardHelper
//            .onWillShow { [weak delegate] in
//                delegate?.keyboardFrameChanged($0)
//            }.onWillHide { [weak delegate] in
//                delegate?.keyboardFrameChanged($0)
//            }

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
        { [weak coordinator] isSuccess in
            print(isSuccess)
            coordinator?.finish()
        }
        
    }
    
    func haveAccountDidTap() {
        print("\(#function)")
        coordinator?.finish()
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
      
}
