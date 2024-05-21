//
//  MapNotificationStorage+Location.swift
//  NoteMe
//
//  Created by George Popkich on 21.04.24.
//

import Foundation
import Storage

struct MapNotificationStorage: MapNotificationStorageUseCaseProtocol {
    
    private let service: NotificationStorage<LocationNotificationDTO>
    
    init(service: NotificationStorage<LocationNotificationDTO>) {
        self.service = service
    }

    func fetch() -> [Storage.LocationNotificationDTO] {
        let dtos: [LocationNotificationDTO] = service.fetch().compactMap {$0 as? LocationNotificationDTO}
        return dtos
    }
    
}
