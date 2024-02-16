//
//  NotificationSections.swift
//  NoteMe
//
//  Created by George Popkich on 15.02.24.
//

import UIKit

enum PopSelectionSections {
    case edit([EditNotificationRows])
    case add([NotificationsRows])
    
    var numberOfRows: Int {
        switch self {
        case .edit(let rows): return rows.count
        case .add(let rows): return rows.count
        }
    }
}

enum EditNotificationRows: CaseIterable {
    case edit
    case delete
    
    var icon: UIImage {
        switch self {
        case .edit: return .Profile.notifiaction
        case .delete : return.Profile.export
        }
    }
    
    var title: String {
        switch self {
        case .edit: return "Edit"
        case .delete: return "Delete"
        }
    }
    
    var hesh: EditNotificationRows {
        switch self {
        case .edit: return .edit
        case .delete: return .delete
        }
    }
   
    
}

enum NotificationsRows: CaseIterable {
    case calendar
    case location
    case timer
    
    var icon: UIImage {
        switch self {
        case .calendar: return .PopNOtifications.calendar
        case .location : return .PopNOtifications.location
        case .timer: return .PopNOtifications.time
        }
    }
    
    var title: String {
        switch self {
        case .calendar: return "Calendar"
        case .location: return "Location"
        case .timer: return "Timer"
        }
    }
    
    var hesh: NotificationsRows {
        switch self {
        case .calendar: return .calendar
        case .location : return .location
        case .timer: return .timer
        }
    }
    
}
