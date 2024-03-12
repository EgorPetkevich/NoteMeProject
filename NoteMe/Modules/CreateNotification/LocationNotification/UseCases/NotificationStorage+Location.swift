//
//  NotificationStorage+Location.swift
//  NoteMe
//
//  Created by George Popkich on 16.02.24.
//

import Foundation
import Storage

struct LocationNotificationStorage: LocationNotificationStorageUseCaseProtocol {
    
    private let service: NotificationStorage<LocationNotificationDTO>
    
    init(service: NotificationStorage<LocationNotificationDTO>) {
        self.service = service
    }
    
    func updateOrCreate(dto: Storage.LocationNotificationDTO,
                        complition: @escaping (Bool) -> Void) {
        service.updateOrCreate(dto: dto, complition: complition)
    }
    
    func create(dto: Storage.LocationNotificationDTO,
                complition: @escaping (Bool) -> Void) {
        service.create(dto: dto, complition: complition)
    }
    
    
}
