//
//  NSPredicate+Const.swift
//  Storage
//
//  Created by George Popkich on 30.01.24.
//

import CoreData

extension NSPredicate {
    enum Notification {
        static func noutification(byId id: String) -> NSPredicate {
            let idKeyPath = #keyPath(BaseNotificationMO.identifier)
            return .init(format: "\(idKeyPath) CONTAINS[cd] %@", id)
        }
    }
}
