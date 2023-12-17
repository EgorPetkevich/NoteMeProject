//
//  RegisteCoordinator.swift
//  NoteMe
//
//  Created by George Popkich on 21.11.23.
//

import UIKit

final class RegisterCoordinator: Coordinator {
    
    private var rootVC: UIViewController?
    
    override func start() -> UIViewController {
        let vc = RegisterAssembler.make(coordinator: self)
        rootVC = vc
        return vc
    }
    
}

extension RegisterCoordinator: RegisterCoordinatorProtocol {
    func showAlert(_ alert: UIAlertController) {
        rootVC?.present(alert, animated: true)
    }
}
