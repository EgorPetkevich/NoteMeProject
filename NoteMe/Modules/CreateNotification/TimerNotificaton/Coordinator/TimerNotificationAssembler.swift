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
    
    @available(iOS 13.4, *)
    static func make(container: Container,
                     coordinator: TimerNotificationCoordinatorProtocol,
                     dto: TimerNotificationDTO? = nil
    ) -> UIViewController {
        
        let keyboardHelper = TimerNotificationKeyboardHelperUseCase(
            keyboardHelper: container.resolve())
        
        let storage = TimerNotificationStorageUseCase(
            service: container.resolve())
        
        let vm = TimerNotificationVM(keyboardHelper: keyboardHelper,
                                     coordinator: coordinator,
                                     storage: storage,
                                     dto: dto)
        
        return TimerNotificationVC(viewModel: vm)
    }
    
}

