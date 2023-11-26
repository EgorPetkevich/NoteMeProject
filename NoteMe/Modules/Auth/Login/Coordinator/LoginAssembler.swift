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
        let vm = LoginVM(authService: TESTAuthService(),
                         inputValidator: InputValidator(),
                         coordinator: coordinator,
                         keyboardHelper: KeyboardHelper())
        return LoginVC(viewModel: vm)
    }
    
}

private class TESTAuthService: LoginAuthServiceUseCase {
    
    func login(email: String,
               password: String,
               completion: @escaping (Bool) -> Void) {
        completion(true)
    }
    
}
