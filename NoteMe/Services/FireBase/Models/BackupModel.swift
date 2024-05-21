//
//  BackupModel.swift
//  NoteMe
//
//  Created by George Popkich on 9.04.24.
//

import Foundation
import Storage

enum BackupErrors: Error {
    case notSupportedBackupType
}

struct BackupModel: Codable {
    
    let dto: any DTODescription
    
    enum CodingKeys: CodingKey {
        //main attributes
        case id
        case title
        case subtitle
        case completedDate
        case type
        //Date & Timer attributes
        case targetDate
        //Location attributes
        case latitude
        case longitude
        case imagePath
        case radius
    }
    
    init(dto: any DTODescription) {
        self.dto = dto
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        let id = try container.decode(String.self, forKey: .id)
        let dateTimeInterval = try container.decode(Double.self, forKey: .targetDate)
        let title = try container.decode(String.self, forKey: .title)
        let subtitle = try container.decodeIfPresent(String.self, forKey: .subtitle)
        let completedDateTimeInterval = try container.decodeIfPresent(Double.self, forKey: .completedDate)
        if type == "date" {
            let targetDateTimeInterval = try container.decode(Double.self, forKey: .targetDate)
            
            let dateDTO = DateNotificationDTO(
                date: Date(timeIntervalSince1970: dateTimeInterval),
                id: id,
                title: title,
                subtitle: subtitle,
                completedDate: Date(completedDateTimeInterval),
                targetDate: Date(timeIntervalSince1970: targetDateTimeInterval))
            self.dto = dateDTO
            return
        }else if type == "timer" {
            let targetDateTimeInterval = try container
                .decode(Double.self,
                        forKey: .targetDate)
            
            let timerDTO = TimerNotificationDTO(
                date: Date(timeIntervalSince1970: dateTimeInterval),
                id: id,
                title: title,
                subtitle: subtitle,
                completedDate: Date(completedDateTimeInterval),
                targetDate: Date(timeIntervalSince1970: targetDateTimeInterval))
            self.dto = timerDTO
            return
        }else if  type == "location" {
            let latitude = try container.decode(Double.self,forKey: .latitude)
            let longitude = try container.decode(Double.self,forKey: .longitude)
            let imagePath = try container.decode(String.self,forKey: .imagePath)
            let radius = try container.decode(Double.self,forKey: .radius)
            let locationDTO = LocationNotificationDTO(
                date: Date(timeIntervalSince1970: dateTimeInterval),
                id: id,
                title: title, 
                latitude: latitude,
                longitude: longitude,
                imagePathStr: imagePath,
                radius: radius)
            self.dto = locationDTO
            return
        }
        //Log Error
        throw BackupErrors.notSupportedBackupType
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy:  CodingKeys.self)
        //main
        try container.encode(dto.id, forKey: .id)
        try container.encode(dto.date.timeIntervalSince1970, forKey: .targetDate)
        try container.encode(dto.title, forKey: .title)
        try container.encode(dto.subtitle, forKey: .subtitle)
        
        if let completedDate = dto.completedDate {
            try container.encode(completedDate.timeIntervalSince1970,
                                 forKey: .completedDate)
        }
        //Date & Timer & Location attributes
        if let dateDTO = dto as? DateNotificationDTO {
            try container.encode(dateDTO.targetDate.timeIntervalSince1970, forKey: .targetDate)
            try container.encode("date", forKey: .type)
        }else if let timerDTO = dto as? TimerNotificationDTO {
            try container.encode(timerDTO.targetDate.timeIntervalSince1970, forKey: .targetDate)
            try container.encode("timer", forKey: .type)
        }else if let locationDTO = dto as? LocationNotificationDTO {
            try container.encode("location", forKey: .type)
            try container.encode(locationDTO.latitude, forKey: .latitude)
            try container.encode(locationDTO.longitude, forKey: .longitude)
            try container.encode(locationDTO.imagePathStr, forKey: .imagePath)
            try container.encode(locationDTO.radius, forKey: .radius)
        }
    }
    
    func buidDict() -> [String: Any]? {
        guard
            let data = try? JSONEncoder().encode(self),
            let dict = try? JSONSerialization
                .jsonObject(with: data,
                            options: .fragmentsAllowed)
        else { return nil }
        
        return dict as? [String: Any]
    }
    
}
