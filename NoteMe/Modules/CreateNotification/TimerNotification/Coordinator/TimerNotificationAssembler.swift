//
//  TimeNotificationAssembler.swift
//  NoteMe
//
//  Created by George Popkich on 16.02.24.
//

import UIKit
import Storage

final class TimerNotificationAssembler {
    
    private init() {}
    
    static func make(container: Container,
                     coordinator: TimerNotificationCoordinatorProtocol,
                     dto: TimerNotificationDTO? = nil
    ) -> UIViewController {
        
        let keyboardHelper = TimerNotificationKeyboardHelperUseCase(
            keyboardHelper: container.resolve())
        
        let storage = TimerNotificationStorageUseCase(
            service: container.resolve())
        
        let notificationService = TimerNotification(
            service: container.resolve())
        
        let vm = TimerNotificationVM(keyboardHelper: keyboardHelper,
                                     coordinator: coordinator,
                                     storage: storage,
                                     notificationService: notificationService,
                                     dto: dto)
        
        return TimerNotificationVC(viewModel: vm)
    }
    
}

