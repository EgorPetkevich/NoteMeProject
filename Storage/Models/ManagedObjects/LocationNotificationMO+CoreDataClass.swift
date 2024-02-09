//
//  LocationNotificationMO+CoreDataClass.swift
//  Storage
//
//  Created by George Popkich on 6.02.24.
//
//

import Foundation
import CoreData

@objc(LocationNotificationMO)
public class LocationNotificationMO: BaseNotificationMO, MODescription {

    public func apply(dto: any DTODescription) {
        guard let dto = dto as? LocationNotificationDTO else { return }
        apply(dto: dto)
    }
    
    func apply(dto: LocationNotificationDTO) {
        self.identifier = dto.id
        self.date = dto.date
        self.title = dto.title
        self.subtitle = dto.subtitle
        self.completedDate = dto.completedDate
        self.location = dto.location
    }
    
}
