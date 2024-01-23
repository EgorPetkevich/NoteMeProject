//
//  AuthService+Profile.swift
//  NoteMe
//
//  Created by George Popkich on 22.01.24.
//

import Foundation

struct ProfileAuthServiceUseCase: ProfileAuthServiceUseCaseProtocol {
    
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func logout(completion: @escaping (Bool) -> Void) {
        authService.signOut(complition: completion)
    }
    
    func getUserEmail() -> String? {
        return authService.currentUser()?.email
    }
}
