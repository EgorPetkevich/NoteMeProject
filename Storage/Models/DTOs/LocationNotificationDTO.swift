//
//  LocationNotificationDTO.swift
//  Storage
//
//  Created by George Popkich on 6.02.24.
//

import Foundation

public struct LocationNotificationDTO: DTODescription {
    
    public typealias DTO = Self
    public typealias MO = LocationNotificationMO
    
    public var id: String
    
    public var title: String
    
    public var subtitle: String?
    
    public var completedDate: Date?
    
    public var location: String?

    public var date: Date
    
    public init(date: Date,
                id: String,
                title: String,
                subtitle: String? = nil,
                completedDate: Date? = nil,
                location: String? = nil) {
        self.date = date
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.completedDate = completedDate
        self.location = location
    }
    
    public init?(mo: LocationNotificationMO) {
        guard
            let id = mo.identifier,
            let title = mo.title,
            let date = mo.date,
            let location = mo.location
        else {return nil}
        
        self.date = date
        self.id = id
        self.title = title
        self.subtitle = mo.subtitle
        self.completedDate = mo.completedDate
        self.location = location
    }
    
}
