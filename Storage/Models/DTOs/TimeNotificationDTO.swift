//
//  .swift
//  Storage
//
//  Created by George Popkich on 6.02.24.
//

import Foundation

public struct TimeNotificationDTO: DTODescription {
    
    public typealias DTO = Self
    public typealias MO = TimeNotificatoinMO
    
    
    public var id: String
    
    public var title: String
    
    public var subtitle: String?
    
    public var completedDate: Date?
    
    public var time: Date?
    
    public var date: Date

    
    public init(date: Date,
                id: String,
                title: String,
                subtitle: String? = nil,
                completedDate: Date? = nil,
                time: Date? = nil) {
        self.date = date
        self.time = time
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.completedDate = completedDate
    }
    
    public init?(mo: TimeNotificatoinMO) {
        guard
            let id = mo.identifier,
            let title = mo.title,
            let time = mo.time,
            let date = mo.date
        else {return nil}
        
        self.time = time
        self.id = id
        self.title = title
        self.subtitle = mo.subtitle
        self.completedDate = mo.completedDate
        self.date = date
        
    }
    
}
