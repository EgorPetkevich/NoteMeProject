//
//  AuthService+Reset.swift
//  NoteMe
//
//  Created by George Popkich on 17.12.23.
//

import Foundation

struct ResetAuthServiceUseCase: ResetAuthServiceUseCaseProtocol {
    
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func reset(email: String, complition: @escaping (Bool) -> Void) {
        authService.sendPasswordReset(email: email, complition: complition)
    }
    
}
