//
//  DateNotificationAssembler.swift
//  NoteMe
//
//  Created by George Popkich on 11.02.24.
//

import UIKit
import Storage

final class DateNotificationAssembler {
    
    private init() {}
    
    @available(iOS 13.4, *)
    static func make(container: Container, coordinator: DateNotificationCoordinatorProtocol) -> UIViewController {
        
        let keyboardHelper = DateNotificationKeyboardHelperUseCase(keyboardHelper: container.resolve())
        let service = NotificationStorage<DateNotificationDTO>()
        
        let vm = DateNotificationVM(keyboardHelper: keyboardHelper, coordinator: coordinator, service: service)
        return DateNotificationVC(viewModel: vm)
    }
    
}
