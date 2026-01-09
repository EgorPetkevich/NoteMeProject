//
//  MainTabBarVM.swift
//  NoteMe
//
//  Created by George Popkich on 13.02.24.
//

import UIKit

protocol MainTabBarCoordinatorProtocol: AnyObject {
    func showMenu(sender: UIView, delegate: MenuPopoverDelegate)
    func openNewDateNotification()
    func openNewLocationNotification()
    func openNewTimerNotification()
}

final class MainTabBarVM: MainTabBarViewModelProtocol {
    
    private weak var coordinator: MainTabBarCoordinatorProtocol?
    
    init(coordinator: MainTabBarCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func addButtonDidTap(sender: UIView) {
        coordinator?.showMenu(sender: sender, delegate: self)
    }
}

    
extension MainTabBarVM: MenuPopoverDelegate {
    
    func didSelect(action: MenuPopoverVC.Action) {
        switch action {
        case .calendar:
            coordinator?.openNewDateNotification()
        case .timer:
            coordinator?.openNewTimerNotification()
        case .location:
            coordinator?.openNewLocationNotification()
        default: break
        }
    }
    
}
