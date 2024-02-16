//
//  LocationNotificationAssembler.swift
//  NoteMe
//
//  Created by George Popkich on 16.02.24.
//

import UIKit
import Storage

final class LocationNotificationAssembler {
    
    private init() {}
    
    @available(iOS 13.4, *)
    static func make(container: Container,
                     coordinator: LocationNotificationCoordinatorProtocol
    ) -> UIViewController {
        
        let keyboardHelper = LocationNotificationKeyboardHelperUseCase(keyboardHelper:
                                                                    container.resolve())
        let storage = LocationNotificationStorage(
            service: NotificationStorage<LocationNotificationDTO>())
        
        let vm = LocationNotificationVM(keyboardHelper: keyboardHelper,
                                    coordinator: coordinator,
                                    service: storage)
        
        return LocationNotificationVC(viewModel: vm)
    }
    
}
