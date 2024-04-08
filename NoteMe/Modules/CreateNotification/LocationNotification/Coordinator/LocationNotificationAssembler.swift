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
    
    static func make(container: Container,
                     coordinator: LocationNotificationCoordinatorProtocol,
                     dto: LocationNotificationDTO? = nil
    ) -> UIViewController {
        
        let keyboardHelper = LocationNotificationKeyboardHelperUseCase(
            keyboardHelper: container.resolve())
        
        let storage = LocationNotificationStorage(
            service: container.resolve())
        
        let fm = LocationFileManagerUseCase(
            fileManagerService: container.resolve())
        
        let notiService = LocationNotification(
            service: container.resolve())
        
        let vm = LocationNotificationVM(keyboardHelper: keyboardHelper,
                                        coordinator: coordinator,
                                        storage: storage,
                                        fileManager: fm,
                                        notificationService: notiService,
                                        dto: dto)
        
        return LocationNotificationVC(viewModel: vm)
    }
    
}
