//
//  AlertService+Login.swift
//  NoteMe
//
//  Created by George Popkich on 18.12.23.
//

import Foundation

extension AlertService: LoginAlertServiceUseCase {
    
    func showLogAlert(title: String, message: String?, okTitle: String) {
        showAlert(title: title, message: message, okTitle: okTitle)
    }
    
}
