//
//  NSSortDescriptor+Const.swift
//  Storage
//
//  Created by George Popkich on 26.02.24.
//

import Foundation
import CoreData

public extension NSSortDescriptor {
    enum Notification {
        public static var byDate: NSSortDescriptor {
            let dateKeyPath = #keyPath(BaseNotificationMO.date)
            return .init(key: dateKeyPath, ascending: false)
        }
    }
}
