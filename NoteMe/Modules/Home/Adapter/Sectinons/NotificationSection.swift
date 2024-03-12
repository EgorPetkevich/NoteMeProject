//
//  NotificationSection.swift
//  NoteMe
//
//  Created by George Popkich on 26.02.24.
//

import UIKit


enum HomeNotificationSections {
    case notifications
    
    var numberOfRows: Int {
        switch self {
        case .notifications: return 1
        default: return 1
        }
    }
}
//
//    enum HomeNotificationsRows: dateNotificationDTO {
//        case date
//        case location
//        case timer
//        
//        var icon: UIImage? {
//            switch self {
//            case .date: return nil
//            case .location: return .location
//            case .timer: return .time
//            }
//        }
//        
//        var title: String {
//            switch self {
//            case .date: return dateNotifications[].title
//            case .location: return "export"
//            case .timer: return "logout"
//            }
//        }
//        
//        var infoText: String? {
//            switch self {
//            case .export: return "Now"
//            default: return nil
//            }
//        }
//        
//    }
//
