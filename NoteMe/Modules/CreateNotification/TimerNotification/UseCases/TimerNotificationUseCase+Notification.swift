//
//  TimerNotificationUseCase+Notification.swift
//  NoteMe
//
//  Created by George Popkich on 8.04.24.
//

import Foundation
import Storage

struct TimerNotification: TimerNotificationServiceUseCaseProtocol {
 
    private var service: NotificationService
    
    init(service: NotificationService) {
        self.service = service
    }
    
    func updateOrCreate(dto: TimerNotificationDTO) {
        service.updateOrCreateNotification(dto: dto)
    }
    
}

