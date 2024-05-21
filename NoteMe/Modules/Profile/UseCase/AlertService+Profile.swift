//
//  AlertService+Profile.swift
//  NoteMe
//
//  Created by George Popkich on 23.04.24.
//

import UIKit

struct ProfileAlertService: ProfileAlertServiceUseCase{
 
    private let service: AlertService
    
    init(service: AlertService) {
        self.service = service
    }
    
    func showAlert(title: String,
                   message: String,
                   okTitile: String) {
        self.service.showAlert(title: title,
                               message: message,
                               okTitle: okTitile)
    }
    
    func showAlert(title: String?,
                   message: String?,
                   cancelTitle: String?,
                   okTitle: String?,
                   okHandler: (() -> Void)?) {
        self.service.showAlert(title: title,
                               message: message,
                               cancelHeldler: nil,
                               okTitle: okTitle,
                               okHandler: okHandler)
    }
    
}
