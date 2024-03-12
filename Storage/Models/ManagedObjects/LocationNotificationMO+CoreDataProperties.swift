//
//  LocationNotificationMO+CoreDataProperties.swift
//  Storage
//
//  Created by George Popkich on 12.03.24.
//
//

import Foundation
import CoreData


extension LocationNotificationMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationNotificationMO> {
        return NSFetchRequest<LocationNotificationMO>(entityName: "LocationNotificationMO")
    }

    @NSManaged public var imagePathStr: String?
    @NSManaged public var latitude: Double
    @NSManaged public var location: String?
    @NSManaged public var longitude: Double
    @NSManaged public var radius: Double

}
