//
//  AlertService+Login.swift
//  NoteMe
//
//  Created by George Popkich on 18.12.23.
//

import Foundation

struct LoginAlertServiceUseCase: LoginAlertServiceUseCaseProtocol {

    private let alertService: AlertService
    
    init(alertService: AlertService) {
        self.alertService = alertService
    }
    
    func showLogAlert(title: String, message: String?, okTitle: String) {
        alertService.showAlert(title: title, message: message, okTitle: okTitle)
    }

}
