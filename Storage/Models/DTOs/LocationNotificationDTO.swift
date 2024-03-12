//
//  LocationNotificationDTO.swift
//  Storage
//
//  Created by George Popkich on 6.02.24.
//

import Foundation
import CoreData

public struct LocationNotificationDTO: DTODescription {
    
    public typealias MO = LocationNotificationMO
    
    public var date: Date
    public var id: String
    public var title: String
    public var subtitle: String?
    public var completedDate: Date?
    public var latitude: Double
    public var longitude: Double
    public var imagePathStr: String
    public var radius: Double
    
    public init(date: Date,
                id: String = UUID().uuidString,
                title: String,
                subtitle: String? = nil,
                completedDate: Date? = nil,
                latitude: Double,
                longitude: Double,
                imagePathStr: String,
                radius: Double) {
        self.date = date
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.completedDate = completedDate
        self.latitude = latitude
        self.longitude = longitude
        self.imagePathStr = imagePathStr
        self.radius = radius
    }
    
    public static func fromMO(_ mo: LocationNotificationMO) -> LocationNotificationDTO? {
        guard
            let date = mo.date,
            let id = mo.identifier,
            let title = mo.title,
            let imagePathStr = mo.imagePathStr
        else { return nil }
        
        return LocationNotificationDTO(
            date: date,
            id: id,
            title: title,
            subtitle: mo.subtitle,
            completedDate: mo.completedDate,
            latitude: mo.latitude,
            longitude: mo.longitude,
            imagePathStr: imagePathStr, 
            radius: mo.radius
        )
    }
    
}
