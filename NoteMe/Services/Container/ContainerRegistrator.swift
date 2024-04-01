//
//  ContainerRegistrator.swift
//  NoteMe
//
//  Created by George Popkich on 22.01.24.
//

import Foundation
import Storage

final class ContainerRegistrator {
    
    static func makeContainer() -> Container {
        let container = Container()
        
        container.register { AlertService(container: container) }
        container.register { AuthService() }
        container.register { KeyboardHelper() }
        container.register { InputValidator() }
        container.register { NotificationStorage<DateNotificationDTO>() }
        container.register { NotificationStorage<LocationNotificationDTO>() }
        container.register { NotificationStorage<TimerNotificationDTO>() }
        container.register { AllNotificationStorage() }
        container.register { FileManagerService.instansce }
        container.register { LocationNetworkService() }
        
        return container
    }
    
}
