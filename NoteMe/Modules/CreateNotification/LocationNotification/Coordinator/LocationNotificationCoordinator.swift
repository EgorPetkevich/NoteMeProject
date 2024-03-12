//
//  LocationNotificationCoordinator.swift
//  NoteMe
//
//  Created by George Popkich on 16.02.24.
//

import UIKit
import Storage

final class LocationNotificationCoordinator: Coordinator {
    
    private var rootVC: UIViewController?
    private let container: Container
    private var dto: LocationNotificationDTO?
    
    init(container: Container, _ dto: LocationNotificationDTO? = nil) {
        self.container = container
        self.dto = dto
    }
    
    override func start() -> UIViewController {
        let vc = LocationNotificationAssembler.make(container: container,
                                                    coordinator: self,
                                                    dto: dto)
        rootVC = vc
        return vc
    }
}

extension LocationNotificationCoordinator:
    LocationNotificationCoordinatorProtocol {
    
    func editMap(locationProperties: LocationProperties?,
                 delegate: LocationDelegate) {
        
        let coordinator = LocationCoordinator(container: container,
                                              delegate: delegate,
                                              locationProperties: locationProperties)
        children.append(coordinator)
        
        let vc = coordinator.start()
      
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll {$0 == coordinator}
            vc.dismiss(animated: true)
        }
        
        vc.modalPresentationStyle = .fullScreen
        rootVC?.present(vc, animated: true)
    }
    
}
