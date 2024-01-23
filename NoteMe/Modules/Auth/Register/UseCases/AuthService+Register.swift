//
//  AuthService+Register.swift
//  NoteMe
//
//  Created by George Popkich on 16.12.23.
//

import Foundation

struct RegisterAuthServiceUseCase: RegisterAuthServiceUseCaseProtocol {
    
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func register(email: String, password: String, repeatPassword: String, complition: @escaping (Bool) -> Void) {
        
        authService.singUp(email: email,
                           password: password,
                           complition: complition)
    }
    
}

