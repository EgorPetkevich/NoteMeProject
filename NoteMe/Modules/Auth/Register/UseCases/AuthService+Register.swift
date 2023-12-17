//
//  AuthService+Register.swift
//  NoteMe
//
//  Created by George Popkich on 16.12.23.
//

import Foundation

extension AuthService: RegisterAuthServiceUseCase {
    func register(email: String, password: String, repeatPassword: String, complition: @escaping (Bool) -> Void) {
        singUp(email: email, password: password, complition: complition)
    }
}
