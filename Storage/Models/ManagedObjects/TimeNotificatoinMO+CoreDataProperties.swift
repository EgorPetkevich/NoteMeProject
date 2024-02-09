//
//  TimeNotificatoinMO+CoreDataProperties.swift
//  Storage
//
//  Created by George Popkich on 6.02.24.
//
//

import Foundation
import CoreData


extension TimeNotificatoinMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TimeNotificatoinMO> {
        return NSFetchRequest<TimeNotificatoinMO>(entityName: "TimeNotificatoinMO")
    }

    @NSManaged public var time: Date?

}
