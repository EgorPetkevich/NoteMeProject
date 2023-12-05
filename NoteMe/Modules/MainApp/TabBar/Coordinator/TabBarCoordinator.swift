//
//  TabBarCoordinator.swift
//  NoteMe
//
//  Created by George Popkich on 5.12.23.
//

import UIKit

final class TabBarCoordinator: Coordinator {
    
    private var rootVC: UIViewController?
    
    override func start() -> UIViewController {
        let vc = TabBarAssembler.make(coordinator: self)
        rootVC = vc
        return vc
    }
}

extension TabBarCoordinator: TabBarCoordinatorProtocol {
    func openHomePage() {
        
    }
    
    func openProfile() {
        
    }
    
    
}
