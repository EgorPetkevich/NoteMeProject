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

protocol ResetAuthServiceUseCaseProtocol {
    func reset(email: String, complition: @escaping (Bool) -> Void)
}

protocol ResetInputValidatorUseCaseProtocol {
    func validate(email: String?) -> Bool
}

protocol KeyboardHelperResetUseCaseProtocol {
    @discardableResult
    func onWillShow(_ handler: @escaping (CGRect) -> Void) -> KeyboardHelper
    @discardableResult
    func onWillHide(_ handler: @escaping (CGRect) -> Void) -> KeyboardHelper
}

protocol ResetAlertServiceUseCaseProtocol {
    func showResetAlert(title: String, message: String, okTitle: String)
}

final class ResetVM: ResetViewModelProtocol {
    
    var keyboardFrameChanged: ((CGRect) -> Void)?
    var catchEmailError: ((String?) -> Void)?
    
    private weak var coordinator: ResetCoordinatorProtocol?
    
    private var keyboardHelper: KeyboardHelperResetUseCaseProtocol
    private var inputValidator: ResetInputValidatorUseCaseProtocol
    private var resetAuthService: ResetAuthServiceUseCaseProtocol
    private var alertService: ResetAlertServiceUseCaseProtocol
    
    init(inputValidator: ResetInputValidatorUseCaseProtocol,
         resetAuthService: ResetAuthServiceUseCaseProtocol,
         coordinator: ResetCoordinatorProtocol?,
         keyboardHelper: KeyboardHelperResetUseCaseProtocol,
         alertService: ResetAlertServiceUseCaseProtocol) {
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
