//
//  AuthService+Reset.swift
//  NoteMe
//
//  Created by George Popkich on 17.12.23.
//

import Foundation

extension AuthService: ResetAuthServiceUseCase {
    func reset(email: String, complition: @escaping (Bool) -> Void) {
        sendPasswordReset(email: email, complition: complition)
    }
    
    
}
