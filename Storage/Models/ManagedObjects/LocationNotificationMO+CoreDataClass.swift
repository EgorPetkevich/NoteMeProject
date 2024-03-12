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
public class LocationNotificationMO: BaseNotificationMO  {
    
    public override func toDTO() -> (any DTODescription)? {
        return LocationNotificationDTO.fromMO(self)
    }
    
    public override func apply(dto: any DTODescription) {
        guard let locationDTO = dto as? LocationNotificationDTO else {
            print("[MODTO]", "\(Self.self) apply failsed: dto is type of \(type(of: dto))")
            return
        }
        super.apply(dto: dto)
        self.latitude = locationDTO.latitude
        self.longitude = locationDTO.longitude
        self.imagePathStr = locationDTO.imagePathStr
    }
    
}
