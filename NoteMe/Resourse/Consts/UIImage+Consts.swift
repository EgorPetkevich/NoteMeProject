//
//  UIImage+Consts.swift
//  NoteMe
//
//  Created by George Popkich on 24.10.23.
//

import UIKit

extension UIImage {
    
    //MARK: General
    enum General {
       static let logo: UIImage = .init(named: "logo")!
    }
    
    //MARK: Unboarding
    enum Onboarding {
        static let infoSet: UIImage = .init(named: "infoSet")!
    }
    
    //MARK: TabBar
    enum TabBar {
        static let selectedHome: UIImage = .init(named: "selectedHome")!
        static let unselectedHome: UIImage = .init(named: "unselectedHome")!
        static let selectedProfile: UIImage = .init(named: "selectedProfile")!
        static let unselectedProfile: UIImage = .init(named: "unselectedProfile")!
        static let plus: UIImage = .init(named: "plus")!
    }
    
    //MARK: Profile
    enum Profile {
        static let notifiaction: UIImage = .init(named: "notifiations")!
        static let export: UIImage = .init(named: "export")!
        static let logout: UIImage = .init(named: "logout")!
    }
    
    //MARK: PopNOtifications
    enum PopNotifications {
        static let calendar: UIImage = .init(named: "calendar")!
        static let location: UIImage = .init(named: "location")!
        static let timer: UIImage = .init(named: "time")!
        static let edit: UIImage = .init(named: "edit_not")!
        static let delete: UIImage = .init(named: "delete")!
    }
    
    //MARK: Home
    enum Home {
        static let edit: UIImage = .init(named: "edit")!
        static let date: UIImage = .init(named: "date")!
        static let location: UIImage = .init(named: "location_home")!
        static let timer: UIImage = .init(named: "timer")!
        static let map: UIImage = .init(named: "map")!
    }
    
    //MARK: Location
    enum Location {
        static let region: UIImage = .init(named: "region")!
    }
    
    enum SearchLocation {
        static let location: UIImage = .init(named: "location_search")!
    }
    
}
