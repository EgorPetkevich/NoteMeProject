//
//  TimeNotificatoinMO+CoreDataClass.swift
//  Storage
//
//  Created by George Popkich on 6.02.24.
//
//

import Foundation
import CoreData

@objc(TimerNotificationMO)
public class TimerNotificationMO: BaseNotificationMO {
    
    public override func toDTO() -> (any DTODescription)? {
        return TimeNotificationDTO.fromMO(self)
    }
    
    public override func apply(dto: any DTODescription) {
        guard let timeDTO = dto as? TimerNotificationDTO else {
            print("[MODTO]", "apply failsed: dto is type of \(type(of: dto))")
            return
        }
        super.apply(dto: dto)
        self.date = timeDTO.date
    }
}
