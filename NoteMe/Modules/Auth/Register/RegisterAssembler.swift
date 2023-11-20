//
//  RegisterAssembler.swift
//  NoteMe
//
//  Created by George Popkich on 14.11.23.
//

import UIKit

final class RegisterAssembler {
    private init() {}
    
    static func make() -> UIViewController {
        let presenter = RegisterPresenter(keyboardHelper: KeyboardHelper(), 
                                          registerAuthService: TESTAuthService(),
                                          inputValidator: InputValidator())
        let vc = RegisterVC(presenter: presenter)
        
        presenter.delegate = vc
        
        return vc
    }
}

private class TESTAuthService: RegisterAuthServiceUseCase {
    func register(email: String, 
                  password: String?,
                  repeatPassword: String?,
                  complition: @escaping (Bool) -> Void) {
        complition(true)
    }
    

}
