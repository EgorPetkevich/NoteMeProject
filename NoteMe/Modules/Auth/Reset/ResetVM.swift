//
//  ResetVM.swift
//  NoteMe
//
//  Created by George Popkich on 21.11.23.
//

import Foundation
protocol ResetAuthServiceUseCase {
    func reset(email: String?, complition: @escaping (Bool) -> Void)
}

protocol ResetInputValidatorUseCase {
    func validate(email: String?) -> Bool
}

final class ResetVM: ResetViewModelProtocol {
    var catchEmailError: ((String?) -> Void)?
    
    
    private var inputValidator: ResetInputValidatorUseCase
    private var resetAuthService: ResetAuthServiceUseCase
    
    init(inputValidator: ResetInputValidatorUseCase,
         resetAuthService: ResetAuthServiceUseCase) {
        self.inputValidator = inputValidator
        self.resetAuthService = resetAuthService
    }
    
    func resetDidTap(email: String?) {
        guard 
            validate(email: email),
            let email
        else { return }
        
        resetAuthService.reset(email: email) { isSuccess in
            print(isSuccess)
        }
    }
    
    func cancelDidTap() {
        
    }
    
    private func validate(email: String?) -> Bool {
        let isEmailValid = inputValidator.validate(email: email)
        catchEmailError?(isEmailValid ? nil : "Wrong Email")
        return isEmailValid
    }
}
