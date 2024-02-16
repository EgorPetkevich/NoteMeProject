//
//  TabBarCoordinator.swift
//  NoteMe
//
//  Created by George Popkich on 5.12.23.
//

import UIKit
import SwiftUI

final class MainTabBarCoordinator: Coordinator {
   
    
    private var rootVC: UIViewController?
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    override func start() -> UIViewController {
        let tabBar = MainTabBarAssembler.make(coordinator: self)
        tabBar.viewControllers = [makeHomeModule(), makeProfileModule()]
        rootVC = tabBar
        return tabBar
    }
    
    private func makeHomeModule() -> UIViewController {
        let coordinator = HomeCoordinator()
        children.append(coordinator)
        
        return coordinator.start()
    }
    
    private func makeProfileModule() -> UIViewController {
        let coordinator = ProfileCoordinator(container: container)
        children.append(coordinator)
        
        return coordinator.start()
    }
    
}
    
extension MainTabBarCoordinator: MainTabBarCoordinatorProtocol {
    
    func showPopNotificationsScreen(view: UIView?,
                                    select: PopNotificationSections) {
        
        let coordinator = PopNotificationSelectorCoordinator(container: container)
        children.append(coordinator)
        
        let vc = coordinator.startPopNotification(select: select)
        
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll {coordinator == $0}
            vc.dismiss(animated: true)
        }
        
        guard let view = view else { return }

//        vc.modalPresentationStyle = .popover
        vc.preferredContentSize = CGSize(width: 180, height: 132)
        vc.popoverPresentationController?.sourceView = view
        vc.popoverPresentationController?.sourceRect = CGRect(x: view.bounds.midX,
                                                              y: view.bounds.midY,
                                                              width: .zero,
                                                              height: .zero)
        vc.popoverPresentationController?.permittedArrowDirections = .down
        
        rootVC?.present(vc, animated: true)
    }
    
}
