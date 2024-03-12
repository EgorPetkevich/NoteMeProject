//
//  NSPredicate+Const.swift
//  Storage
//
//  Created by George Popkich on 30.01.24.
//

import CoreData

public extension NSPredicate {
    enum Notification {
        public static var allNotCompleted: NSPredicate {
            let completedDateKeyPath = #keyPath(BaseNotificationMO.completedDate)
            return .init(format: "\(completedDateKeyPath) == NULL")
        }
        static func noutification(byId id: String) -> NSPredicate {
            let idKeyPath = #keyPath(BaseNotificationMO.identifier)
            return .init(format: "\(idKeyPath) CONTAINS[cd] %@", id)
        }
    }
}
