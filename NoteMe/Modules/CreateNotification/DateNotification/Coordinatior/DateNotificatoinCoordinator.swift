//
//  DateNotificatoinCoordinator.swift
//  NoteMe
//
//  Created by George Popkich on 11.02.24.
//

import UIKit

@available(iOS 13.4, *)
final class DateNotificationCoordinator: Coordinator {
    
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    override func start() -> UIViewController {
        let vc = DateNotificationAssembler.make(container: container,
                                                coordinator: self)
        return vc
    }
}

@available(iOS 13.4, *)
extension DateNotificationCoordinator: DateNotificationCoordinatorProtocol {
    
}
