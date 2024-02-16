//
//  TimeNotificationCoordinator.swift
//  NoteMe
//
//  Created by George Popkich on 16.02.24.
//

import UIKit

@available(iOS 13.4, *)
final class TimeNotificationCoordinator: Coordinator {
    
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    override func start() -> UIViewController {
        let vc = TimeNotificationAssembler.make(container: container,
                                                coordinator: self)
        return vc
    }
}

@available(iOS 13.4, *)
extension TimeNotificationCoordinator: TimeNotificationCoordinatorProtocol {
    
}

