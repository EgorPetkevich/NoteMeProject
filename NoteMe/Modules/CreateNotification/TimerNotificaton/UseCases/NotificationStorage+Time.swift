//
//  NotificationStorage+Time.swift
//  NoteMe
//
//  Created by George Popkich on 16.02.24.
//

import Foundation
import Storage

struct TimeNotificationStorage: TimeNotificationStorageUseCaseProtocol {
    
    private let service: NotificationStorage<TimeNotificationDTO>
    
    init(service: NotificationStorage<TimeNotificationDTO>) {
        self.service = service
    }
    
    func create(dto: Storage.TimeNotificationDTO,
                complition: @escaping (Bool) -> Void) {
        service.create(dto: dto, complition: complition)
    }
    
    
}
