//
//  MapNotificationCoordinator.swift
//  NoteMe
//
//  Created by George Popkich on 9.04.24.
//

import UIKit

final class MapNotificationCoordinator: Coordinator {
    
    private var rootVC: UIViewController?
    
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    override func start() -> UIViewController {
        let vc = MapNotificationAssembler.make(container: container,
                                    coordinator: self)
        rootVC = vc
        return vc
    }
    
}

extension MapNotificationCoordinator: MapNotificationCoordinatorProtocol {
    
    func pinDidTap(title: String?, subtitle: String?) {
        let coordinator = MapNotificationInfoCoordinator(title: title,
                                                         subtitle: subtitle)
        children.append(coordinator)
        
        let vc = coordinator.start()
        
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll {coordinator == $0}
            vc.dismiss(animated: true)
        }
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .formSheet
            if let sheet = nav.sheetPresentationController {
                sheet.detents = [.medium()]
            }
        rootVC?.present(nav, animated: true, completion: nil)

    }
    
}
