//
//  TabBarVM.swift
//  NoteMe
//
//  Created by George Popkich on 5.12.23.
//

import UIKit

protocol TabBarCoordinatorProtocol: AnyObject {
    func openHomePage()
    func openProfile()
}

final class TabBarVM: TabBarViewModelProtocol {
    
    private weak var coordinator: TabBarCoordinatorProtocol?
    
    init(coordinator: TabBarCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func homeButtonDidTap() {
        
    }
    
    func profileButtonDidTap() {
        
    }
    
    
    
}
