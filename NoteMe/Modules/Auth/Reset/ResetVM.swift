//
//  ResetVM.swift
//  NoteMe
//
//  Created by George Popkich on 21.11.23.
//
import UIKit

protocol ResetCoordinatorProtocol: AnyObject {
    func finish()
    func showAlert(_ alert: UIAlertController)
}

protocol ResetAuthServiceUseCase {
    func reset(email: String, complition: @escaping (Bool) -> Void)
}

protocol ResetInputValidatorUseCase {
    func validate(email: String?) -> Bool
}

protocol KeyboardHelperResetUseCase {
    @discardableResult
    func onWillShow(_ handler: @escaping (CGRect) -> Void) -> Self
    @discardableResult
    func onWillHide(_ handler: @escaping (CGRect) -> Void) -> Self
}

protocol ResetAlertServiceUseCase {
    func showResetAlert(title: String, message: String, okTitle: String)
}

final class ResetVM: ResetViewModelProtocol {
    
    var keyboardFrameChanged: ((CGRect) -> Void)?
    var catchEmailError: ((String?) -> Void)?
    
    private weak var coordinator: ResetCoordinatorProtocol?
    
    private var keyboardHelper: KeyboardHelperResetUseCase
    private var inputValidator: ResetInputValidatorUseCase
    private var resetAuthService: ResetAuthServiceUseCase
    private var alertService: ResetAlertServiceUseCase
    
    init(inputValidator: ResetInputValidatorUseCase,
         resetAuthService: ResetAuthServiceUseCase,
         coordinator: ResetCoordinatorProtocol?,
         keyboardHelper: KeyboardHelperResetUseCase,
         alertService: ResetAlertServiceUseCase) {
        self.inputValidator = inputValidator
        self.resetAuthService = resetAuthService
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
    
    func resetDidTap(email: String?) {
        print("\(#function)")
        guard
            validate(email: email),
            let email
        else { return }
        
        resetAuthService.reset(email: email) { [weak self]
            isSuccess in
            print(isSuccess)
            if isSuccess {
                //FIXME: uncomment
                self?.alertService.showResetAlert(
                    title: "Password reset ",
                    message: "We send a password reset email to you",
                    okTitle: "Ok")
                
                self?.coordinator?.finish()
            }else {
                self?.alertService.showResetAlert(
                    title: "Error",
                    message: "Invalid Email",
                    okTitle: "Ok")

                self?.errorValidation()
            }
        }
    }
    
    func cancelDidTap() {
        print("\(#function)")
        coordinator?.finish()
    }
    
    private func validate(email: String?) -> Bool {
        let isEmailValid = inputValidator.validate(email: email)
        errorValidation(isEmailValid: isEmailValid)
        return isEmailValid
    }
    
    private func errorValidation(isEmailValid: Bool = false) {
        catchEmailError?(isEmailValid ? nil : .Auth.resetEmailError)
    }
    
}
