//
//  TabBarAssembler.swift
//  NoteMe
//
//  Created by George Popkich on 5.12.23.
//

import UIKit

final class MainTabBarAssembler {
    
    private init() {}
    
    static func make(coordinator: MainTabBarCoordinatorProtocol) -> UITabBarController {
        let vm = MainTabBarVM(coordinator: coordinator)
        let tabBar = MainTabBarVC(viewModel: vm)
        return tabBar
    }
    
}
