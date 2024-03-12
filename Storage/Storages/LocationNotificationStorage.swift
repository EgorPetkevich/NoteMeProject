//
//  LocationNotificationStorage.swift
//  Storage
//
//  Created by George Popkich on 6.02.24.
//

import CoreData

public final class LocationNotificationStorage:
    NotificationStorage<LocationNotificationDTO> {
    
    public func fetch(predicate: NSPredicate? = nil,
                      sortDescriptors: [NSSortDescriptor] = []
    ) -> [LocationNotificationDTO] {
        return super.fetch(predicate: predicate,
                           sortDescriptors: sortDescriptors
        ).compactMap { $0 as? LocationNotificationDTO }
    }
}
