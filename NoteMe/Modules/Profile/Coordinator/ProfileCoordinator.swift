//
//  ProfileCoordinator.swift
//  NoteMe
//
//  Created by George Popkich on 19.12.23.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    
    private var rootVC: UIViewController?
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    override func start() -> UIViewController {
        let vc = ProfileAssembler.make(container: container,
                                       coordinator: self)
        self.rootVC = vc
        return vc
    }
    
}

extension ProfileCoordinator: ProfileCoordinatorProtocol {
    
    func openMap() {
        let coordinator = MapNotificationCoordinator(container: container)
        children.append(coordinator)
        
        let vc = coordinator.start()
        
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll {coordinator == $0}
            vc.dismiss(animated: true)
        }
        
        vc.modalPresentationStyle = .fullScreen
        rootVC?.present(vc, animated: true)
    }
   
}
