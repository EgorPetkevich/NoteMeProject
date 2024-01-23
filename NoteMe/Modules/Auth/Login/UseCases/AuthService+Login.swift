//
//  AuthService+Login.swift
//  NoteMe
//
//  Created by George Popkich on 5.12.23.
//

import Foundation

struct LoginAuthServiceUseCase: LoginAuthServiceUseCaseProtocol {
    
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        authService.singIn(email: email,
                           password: password,
                           complition: completion)
    }
    
    
}

