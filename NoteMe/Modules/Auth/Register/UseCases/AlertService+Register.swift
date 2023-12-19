//
//  AlertService+Register.swift
//  NoteMe
//
//  Created by George Popkich on 18.12.23.
//

import Foundation

extension AlertService: RegisterAlertServiceUseCase {
    
    func showRegisterAlert(title: String, message: String?, okTitle: String) {
        showAlert(title: title, message: message, okTitle: okTitle)
    }
    
}
