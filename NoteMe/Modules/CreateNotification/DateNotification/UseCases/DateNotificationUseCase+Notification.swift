//
//  DateNotificationUseCase+Notification.swift
//  NoteMe
//
//  Created by George Popkich on 8.04.24.
//

import Foundation
import Storage

struct DateNotification: DateNotificationServiceUseCaseProtocol {
 
    private var service: NotificationService
    
    init(service: NotificationService) {
        self.service = service
    }
    
    func updateOrCreate(dto: DateNotificationDTO) {
        service.updateOrCreateNotification(dto: dto)
    }
    
}
