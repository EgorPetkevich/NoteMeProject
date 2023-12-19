//
//  TapBarVC.swift
//  NoteMe
//
//  Created by George Popkich on 5.12.23.
//

import UIKit


final class MainTabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .appYellow
        tabBar.backgroundColor = .appBackground
        tabBar.unselectedItemTintColor = .appInfoWhite
    }
    
}
