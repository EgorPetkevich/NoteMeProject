//
//  NotificationStorage+Time.swift
//  NoteMe
//
//  Created by George Popkich on 16.02.24.
//

import Foundation
import Storage

struct TimerNotificationStorageUseCase: TimerNotificationStorageUseCaseProtocol {
    
    private let service: NotificationStorage<TimerNotificationDTO>
    
    init(service: NotificationStorage<TimerNotificationDTO>) {
        self.service = service
    }
    
    func updateOrCreate(dto: Storage.TimerNotificationDTO,
                        complition: @escaping (Bool) -> Void) {
        service.updateOrCreate(dto: dto, complition: complition)
    }
    
    func create(dto: Storage.TimerNotificationDTO,
                complition: @escaping (Bool) -> Void) {
        service.create(dto: dto, complition: complition)
    }
    
    
}
