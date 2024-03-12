//
//  TimeNotificationCoordinator.swift
//  NoteMe
//
//  Created by George Popkich on 16.02.24.
//

import UIKit
import Storage

@available(iOS 13.4, *)
final class TimerNotificationCoordinator: Coordinator {
    
    private let container: Container
    private let dto: TimerNotificationDTO?
    
    init(container: Container, _ dto: TimerNotificationDTO? = nil) {
        self.container = container
        self.dto = dto
    }
    
    override func start() -> UIViewController {
        let vc = TimerNotificationAssembler.make(container: container,
                                                coordinator: self,
                                                 dto: dto)
        return vc
    }
}

@available(iOS 13.4, *)
extension TimerNotificationCoordinator: TimerNotificationCoordinatorProtocol {
    
}

