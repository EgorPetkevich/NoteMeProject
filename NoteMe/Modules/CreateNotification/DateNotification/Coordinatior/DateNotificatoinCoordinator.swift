//
//  DateNotificatoinCoordinator.swift
//  NoteMe
//
//  Created by George Popkich on 11.02.24.
//

import UIKit
import Storage

@available(iOS 13.4, *)
final class DateNotificationCoordinator: Coordinator {
    
    private let container: Container
    private let dto: DateNotificationDTO?
    
    init(container: Container, _ dto: DateNotificationDTO? = nil) {
        self.container = container
        self.dto = dto
    }
    
    override func start() -> UIViewController {
        let vc = DateNotificationAssembler.make(container: container,
                                                coordinator: self,
                                                dto: dto)
        return vc
    }
}

@available(iOS 13.4, *)
extension DateNotificationCoordinator: DateNotificationCoordinatorProtocol {
    
}
