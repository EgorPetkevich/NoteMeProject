//
//  HomeDTOMock.swift
//  NoteMeTests
//
//  Created by George Popkich on 26.03.24.
//

import Foundation
import Storage
import CoreData

struct HomeDTOMock: DTODescription {
    
    typealias MO = BaseNotificationMO
    
    var id: String = "testID"
    var date: Date = .init()
    var title: String = "testTitle"
    var subtitle: String? = nil
    var completedDate: Date? = nil
    
    static func fromMO(_ mo: Storage.BaseNotificationMO) -> HomeDTOMock? {
        return nil
    }
    
}
