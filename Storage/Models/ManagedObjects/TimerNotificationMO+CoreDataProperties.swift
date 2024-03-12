//
//  TimerNotificationMO+CoreDataProperties.swift
//  Storage
//
//  Created by George Popkich on 26.02.24.
//
//

import Foundation
import CoreData


extension TimerNotificationMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TimerNotificationMO> {
        return NSFetchRequest<TimerNotificationMO>(entityName: "TimerNotificationMO")
    }

    @NSManaged public var targetDate: Date?

}
