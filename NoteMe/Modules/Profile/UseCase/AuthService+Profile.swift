//
//  AuthService+Profile.swift
//  NoteMe
//
//  Created by George Popkich on 22.01.24.
//

import Foundation

extension AuthService: ProfileAuthServiceUseCase {
    
    func logout(completion: @escaping (Bool) -> Void) {
        self.signOut(complition: completion)
    }
    
    func getUserEmail() -> String? {
        return self.currentUser()?.email
    }
}
