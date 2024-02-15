//
//  TimeNotificatoinMO+CoreDataClass.swift
//  Storage
//
//  Created by George Popkich on 6.02.24.
//
//

import Foundation
import CoreData

@objc(TimeNotificatoinMO)
public class TimeNotificatoinMO: BaseNotificationMO, MODescription {
    
    public typealias DTO = TimeNotificationDTO
    
    public func apply(dto: TimeNotificationDTO) {
        self.identifier = dto.id
        self.date = dto.date
        self.title = dto.title
        self.subtitle = dto.subtitle
        self.completedDate = dto.completedDate
        self.time = dto.time
    }
    
}

