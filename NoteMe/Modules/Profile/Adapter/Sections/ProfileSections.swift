//
//  ProfileSections.swift
//  NoteMe
//
//  Created by George Popkich on 29.01.24.
//

import UIKit

enum ProfileSections {
    case account(String)
    case settings([ProfileSettingsRows])
    
    var numberOfRows: Int {
        switch self {
        case .settings(let rows): return rows.count
        default: return 1
        }
    }
    
    var headerText: String {
        switch self {
        case .account: return "Account"
        case .settings(_): return "Settings"
        }
    }
}

enum ProfileSettingsRows: CaseIterable {
    case notifications
    case export
    case logout
    
    var icon: UIImage {
        switch self {
        case .notifications: return .Profile.notifiaction
        case .export : return.Profile.export
        case .logout: return .Profile.logout
        }
    }
    
    var title: String {
        switch self {
        case .notifications: return "notificatins"
        case .export: return "export"
        case .logout: return "logout"
        }
    }
    
    var infoText: String? {
        switch self {
        case .export: return "Now"
        default: return nil
        }
    }
    
}
