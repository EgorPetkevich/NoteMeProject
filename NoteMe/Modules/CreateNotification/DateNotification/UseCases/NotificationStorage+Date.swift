//
//  NotificationStorage+Date.swift
//  NoteMe
//
//  Created by George Popkich on 16.02.24.
//

import Foundation
import Storage

struct DateNotificationStorageUseCase: DateNotificationStorageUseCaseProtocol {
    
    private let service: NotificationStorage<DateNotificationDTO>
    
    init(service: NotificationStorage<DateNotificationDTO>) {
        self.service = service
    }
    
    func updateOrCreate(dto: Storage.DateNotificationDTO,
                        complition: @escaping (Bool) -> Void) {
        service.updateOrCreate(dto: dto, complition: complition)
    }
    
    func create(dto: Storage.DateNotificationDTO,
                complition: @escaping (Bool) -> Void) {
        service.create(dto: dto, complition: complition)
    }

}
