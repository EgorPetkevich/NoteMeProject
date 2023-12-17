//
//  ResetCoordinator.swift
//  NoteMe
//
//  Created by George Popkich on 26.11.23.
//

import UIKit

final class ResetCoordinator: Coordinator {
    
    private var rootVC: UIViewController?
    
    override func start() -> UIViewController {
        let vc = ResetAssembler.make(coordinator: self)
        rootVC = vc
        return vc
    }
}

extension ResetCoordinator: ResetCoordinatorProtocol {
    func showAlert(_ alert: UIAlertController) {
        rootVC?.present(alert, animated: true)
    }
}
