//
//  RegisterAssembler.swift
//  NoteMe
//
//  Created by George Popkich on 14.11.23.
//

import UIKit

final class RegisterAssembler {
    
    private init() {}
    
    static func make(container: Container,
                     coordinator: RegisterCoordinatorProtocol) -> UIViewController {
        
        let authService =  RegisterAuthServiceUseCase(authService: container.resolve())
        let keyboardHelper = ReginsterKeyboardHelperRegisterUseCase(keyboardHelper: container.resolve())
        let inputValidator = RegisterInputValidatorUseCase(inputValidator: container.resolve())
        let alertServict = RegisterAlertServiceUseCase(alertService: container.resolve())
        
        let presenter = RegisterPresenter(keyboardHelper: keyboardHelper,
                                          registerAuthService: authService,
                                          inputValidator: inputValidator,
                                          coordinator: coordinator,
                                          alertService: alertServict)
        let vc = RegisterVC(presenter: presenter)
        
        presenter.delegate = vc
        
        return vc
    }
    
}
    
