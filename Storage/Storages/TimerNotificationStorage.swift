//
//  TimerNotificationStorage.swift
//  Storage
//
//  Created by George Popkich on 6.02.24.
//

import CoreData

public final class TimerNotificationStorage:
    NotificationStorage<TimerNotificationDTO> {
    
    public func fetch(predicate: NSPredicate? = nil,
                      sortDescriptors: [NSSortDescriptor] = []
    ) -> [TimerNotificationDTO] {
        return super.fetch(predicate: predicate,
                           sortDescriptors: sortDescriptors
        ).compactMap { $0 as? TimerNotificationDTO }
    }
    
}
 
