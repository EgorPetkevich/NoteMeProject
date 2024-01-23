//
//  LoginAssembler.swift
//  NoteMe
//
//  Created by George Popkich on 10.11.23.
//

import UIKit

final class LoginAssembler {
    
    private init() {}
    
    static func make(container: Container,
                     coordinator: LoginCoordinatorProtocol) -> UIViewController {
        
        let authUseCase = LoginAuthServiceUseCase(authService: container.resolve())
        let inputValidator = LoginInputValidatorUseCase(inputValidator: container.resolve())
        let alertServict = LoginAlertServiceUseCase(alertService: container.resolve())
        let keyboardHelper = LoginKeyboardHelperUseCase(keyboardHelper: container.resolve())
        
        let vm = LoginVM(authService: authUseCase,
                         inputValidator: inputValidator,
                         coordinator: coordinator,
                         keyboardHelper: keyboardHelper,
                         alertService: alertServict)
        return LoginVC(viewModel: vm)
    }
    
}
