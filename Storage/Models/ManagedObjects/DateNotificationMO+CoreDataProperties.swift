//
//  DateNotificationMO+CoreDataProperties.swift
//  Storage
//
//  Created by George Popkich on 5.02.24.
//
//

import Foundation
import CoreData


extension DateNotificationMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DateNotificationMO> {
        return NSFetchRequest<DateNotificationMO>(entityName: "DateNotificationMO")
    }

    @NSManaged public var targetDate: Date?

}


