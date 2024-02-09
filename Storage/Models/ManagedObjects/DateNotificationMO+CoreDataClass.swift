//
//  DateNotificationMO+CoreDataClass.swift
//  Storage
//
//  Created by George Popkich on 5.02.24.
//
//

import Foundation
import CoreData

@objc(DateNotificationMO)
public class DateNotificationMO: BaseNotificationMO, MODescription {
    
    public func apply(dto: any DTODescription) {
        guard let dto = dto as? DateNotificationDTO else { return }
        apply(dto: dto)
    }
    
    func apply(dto: DateNotificationDTO) {
        self.identifier = dto.id
        self.date = dto.date
        self.title = dto.title
        self.subtitle = dto.subtitle
        self.completedDate = dto.completedDate
        self.targetDate = dto.targetDate
    }
    
}

