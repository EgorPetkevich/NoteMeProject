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
    static func make(container: Container,
                     coordinator: DateNotificationCoordinatorProtocol,
                     dto: DateNotificationDTO? = nil
    ) -> UIViewController {
        
        let keyboardHelper = DateNotificationKeyboardHelperUseCase(
            keyboardHelper: container.resolve())
        
        let storage =  DateNotificationStorageUseCase(
            service: container.resolve())
        
        let vm = DateNotificationVM(keyboardHelper: keyboardHelper, 
                                    coordinator: coordinator,
                                    storage: storage,
                                    dto: dto)
        
        return DateNotificationVC(viewModel: vm)
    }
    
}
