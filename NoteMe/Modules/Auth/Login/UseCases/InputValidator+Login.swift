//
//  InputValidator+Login.swift
//  NoteMe
//
//  Created by George Popkich on 10.11.23.
//

import Foundation

struct LoginInputValidatorUseCase: LoginInputValidatorUseCaseProtocol {
    
    private let inputValidator: InputValidator
    
    init(inputValidator: InputValidator) {
        self.inputValidator = inputValidator
    }
    
    func validate(email: String?) -> Bool {
        inputValidator.validate(email: email)
    }
    
    func validate(password: String?) -> Bool {
        inputValidator.validate(password: password)
    }
    
    
}

