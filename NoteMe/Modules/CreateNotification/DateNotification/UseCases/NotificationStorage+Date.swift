//
//  NotificationStorage+Date.swift
//  NoteMe
//
//  Created by George Popkich on 16.02.24.
//

import Foundation
import Storage

struct DateNotificationStorage: DateNotificationStorageUseCaseProtocol {
    
    private let service: NotificationStorage<DateNotificationDTO>
    
    init(service: NotificationStorage<DateNotificationDTO>) {
        self.service = service
    }
    
    func create(dto: Storage.DateNotificationDTO,
                complition: @escaping (Bool) -> Void) {
        service.create(dto: dto, complition: complition)
    }
    
    
}
