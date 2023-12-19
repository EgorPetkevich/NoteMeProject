//
//  TabBarAssembler.swift
//  NoteMe
//
//  Created by George Popkich on 5.12.23.
//

import UIKit

final class MainTabBarAssembler {
    
    private init() {}
    
    static func make() -> UITabBarController {
        let tabBar = MainTabBarVC()
        return tabBar
    }
    
}
