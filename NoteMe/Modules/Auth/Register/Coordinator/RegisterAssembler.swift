//
//  RegisterAssembler.swift
//  NoteMe
//
//  Created by George Popkich on 14.11.23.
//

import UIKit

final class RegisterAssembler {
    
    private init() {}
    
    static func make(coordinator: RegisterCoordinatorProtocol) -> UIViewController {
        let presenter = RegisterPresenter(keyboardHelper: KeyboardHelper(),
                                          registerAuthService: AuthService(),
                                          inputValidator: InputValidator(),
                                          coordinator: coordinator,
                                          alertService: AlertService.current)
        let vc = RegisterVC(presenter: presenter)
        
        presenter.delegate = vc
        
        return vc
    }
    
}
    
