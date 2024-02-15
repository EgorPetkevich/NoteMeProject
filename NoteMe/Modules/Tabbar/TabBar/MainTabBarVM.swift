//
//  MainTabBarVM.swift
//  NoteMe
//
//  Created by George Popkich on 13.02.24.
//

import UIKit

protocol MainTabBarCoordinatorProtocol: AnyObject {
    func showPopNotificationsScreen(view: UIView?,
                                    select: PopNotificationSections)
}

final class MainTabBarVM: MainTabBarViewModelProtocol {
  
    private weak var coordinator: MainTabBarCoordinatorProtocol?
    
    init(coordinator: MainTabBarCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    
    func plusButtonDidTap(view: UIView?, select: PopNotificationSections) {
        coordinator?.showPopNotificationsScreen(view: view, select: select)
    }
    
    
}
