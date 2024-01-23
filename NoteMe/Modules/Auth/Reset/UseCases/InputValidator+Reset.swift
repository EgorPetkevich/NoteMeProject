//
//  InputValidator+Reset.swift
//  NoteMe
//
//  Created by George Popkich on 21.11.23.
//

import Foundation

struct ResetInputValidatorUseCase: ResetInputValidatorUseCaseProtocol {
    
    private let inputValidator: InputValidator
    
    init(inputValidator: InputValidator) {
        self.inputValidator = inputValidator
    }
    
    func validate(email: String?) -> Bool {
        inputValidator.validate(email: email)
    }
    
}
