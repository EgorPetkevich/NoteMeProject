//
//  TimeNotificationAssembler.swift
//  NoteMe
//
//  Created by George Popkich on 16.02.24.
//

import UIKit
import Storage

final class TimeNotificationAssembler {
    
    private init() {}
    
    @available(iOS 13.4, *)
    static func make(container: Container,
                     coordinator: TimeNotificationCoordinatorProtocol
    ) -> UIViewController {
        
        let keyboardHelper = TimeNotificationKeyboardHelperUseCase(keyboardHelper:
                                                                    container.resolve())
        
        let storage = TimeNotificationStorage(
            service: NotificationStorage<TimeNotificationDTO>())
        
        let vm = TimeNotificationVM(keyboardHelper: keyboardHelper,
                                    coordinator: coordinator,
                                    service: storage)
        
        return TimeNotificationVC(viewModel: vm)
    }
    
}

