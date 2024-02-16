//
//  LocationNotificationCoordinator.swift
//  NoteMe
//
//  Created by George Popkich on 16.02.24.
//

import UIKit

final class LocationNotificationCoordinator: Coordinator {
    
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    override func start() -> UIViewController {
        let vc = LocationNotificationAssembler.make(container: container,
                                                coordinator: self)
        return vc
    }
}

extension LocationNotificationCoordinator:
    LocationNotificationCoordinatorProtocol {
    
}
