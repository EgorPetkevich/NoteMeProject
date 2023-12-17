//
//  AuthService.swift
//  NoteMe
//
//  Created by George Popkich on 5.12.23.
//

import Foundation
import FirebaseAuth

final class AuthService {
    
    private var fireBase: Auth {
        return Auth.auth()
    }
    
    func singIn(email: String,
                password: String,
                complition: @escaping (Bool) -> Void) {
        fireBase.signIn(withEmail: email, 
                        password: password)  {result, error in
            complition(error == nil)
        }
    }
    
    func singUp(email: String,
                password: String,
                complition: @escaping (Bool) -> Void) {
        fireBase.createUser(withEmail: email,
                            password: password) {result, error in
        complition(error == nil)
        }
    }
    
    func sendPasswordReset(email: String, 
                           complition: @escaping (Bool) -> Void) {
        fireBase.sendPasswordReset(withEmail: email) { error in
            complition(error == nil)
        }
    }
    
}
