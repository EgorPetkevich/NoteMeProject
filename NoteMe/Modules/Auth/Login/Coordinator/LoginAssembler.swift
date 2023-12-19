//
//  LoginAssembler.swift
//  NoteMe
//
//  Created by George Popkich on 10.11.23.
//

import UIKit

final class LoginAssembler {
    
    private init() {}
    
    static func make(coordinator: LoginCoordinatorProtocol) -> UIViewController {
        let vm = LoginVM(authService: AuthService(),
                         inputValidator: InputValidator(),
                         coordinator: coordinator,
                         keyboardHelper: KeyboardHelper(),
                         alertService: AlertService.current)
        return LoginVC(viewModel: vm)
    }
    
}
