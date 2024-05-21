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
    
    static func make(container: Container,
                     coordinator: DateNotificationCoordinatorProtocol,
                     dto: DateNotificationDTO? = nil
    ) -> UIViewController {
        
        let keyboardHelper = DateNotificationKeyboardHelperUseCase(
            keyboardHelper: container.resolve())
        let dataWorker = DateDataWorker(dataWorker: container.resolve())
        
        let vm = DateNotificationVM(keyboardHelper: keyboardHelper, 
                                    coordinator: coordinator,
                                    dataWorker: dataWorker,
                                    dto: dto)
        
        return DateNotificationVC(viewModel: vm)
    }
    
}
