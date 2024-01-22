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
    }
    
    //MARK: Profile
    enum Profile {
        static let notifiaction: UIImage = .init(named: "notifiations")!
        static let export: UIImage = .init(named: "export")!
        static let logout: UIImage = .init(named: "logout")!
    }
    

}
