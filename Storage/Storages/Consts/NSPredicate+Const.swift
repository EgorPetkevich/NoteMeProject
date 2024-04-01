//
//  NSPredicate+Const.swift
//  Storage
//
//  Created by George Popkich on 30.01.24.
//

import CoreData

public extension NSPredicate {
    
    enum Notification {
        public static var allNotComplited: NSPredicate {
            let complitedDateKeyPath = #keyPath
            (BaseNotificationMO.completedDate)
            return .init(format: "\(complitedDateKeyPath) = NULL")
        }
         
        public static func noutification(byId id: String) -> NSPredicate {
            let idKeyPath = #keyPath(BaseNotificationMO.identifier)
            return .init(format: "\(idKeyPath) CONTAINS[cd] %@", id)
        }
    }
}
