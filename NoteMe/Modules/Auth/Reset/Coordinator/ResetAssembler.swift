//
//  ResetAssembler.swift
//  NoteMe
//
//  Created by George Popkich on 21.11.23.
//

import UIKit

final class ResetAssembler {
    
    private init() {}
    
    static func make(container: Container,
                     coordinator: ResetCoordinatorProtocol) -> UIViewController {
        
        let authService =  ResetAuthServiceUseCase(authService: container.resolve())
        let keyboardHelper = ResetKeyboardHelperRegisterUseCase(keyboardHelper: container.resolve())
        let inputValidator = ResetInputValidatorUseCase(inputValidator: container.resolve())
        let alertServict = ResetAlertServiceUseCase(alertService: container.resolve())
        
        let vm = ResetVM(inputValidator: inputValidator,
                         resetAuthService: authService,
                         coordinator: coordinator,
                         keyboardHelper: keyboardHelper,
                         alertService: alertServict)
        let vc = ResetVC(viewModel: vm)
        
        return vc
    }
    
}

