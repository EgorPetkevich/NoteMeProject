//
//  PopNotificationCoordinator.swift
//  NoteMe
//
//  Created by George Popkich on 15.02.24.
//

import UIKit

final class PopNotificationSelectorCoordinator: Coordinator {
    
    private var rootVC: UIViewController?
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    func startPopNotification(select: PopNotificationSections
    ) -> UIViewController {
        let vc = PopNotificationSelectorAssembler.make(container: container,
                                                       coordinator: self,
                                                       select: select)
        self.rootVC = vc
        return vc
    }
    
    
    override func start() -> UIViewController {
        let vc = PopNotificationSelectorAssembler.make(container: container,
                                                       coordinator: self,
                                                       select: .edit)
        return vc
    }
    
}


extension PopNotificationSelectorCoordinator: 
    PopNotificationSelectorCoordinatorProtocol {

    func openCalendar() {
        let coordinator = DateNotificationCoordinator(container: container)
        children.append(coordinator)
        
        let vc = coordinator.start()
        
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll {coordinator == $0}
            vc.dismiss(animated: true)
            self?.finish()
        }
        
        vc.modalPresentationStyle = .fullScreen
        rootVC?.present(vc, animated: true)
    }
    
    func openLocation() {
        let coordinator = LocationNotificationCoordinator(container: container)
        children.append(coordinator)
        
        let vc = coordinator.start()
        
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll {coordinator == $0}
            vc.dismiss(animated: true)
            self?.finish()
        }
        
        vc.modalPresentationStyle = .fullScreen
        rootVC?.present(vc, animated: true)
    }
    
    func openTime() {
        let coordinator = TimerNotificationCoordinator(container: container)
        children.append(coordinator)
        
        let vc = coordinator.start()
        
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll {coordinator == $0}
            vc.dismiss(animated: true)
            self?.finish()
        }
        
        vc.modalPresentationStyle = .fullScreen
        rootVC?.present(vc, animated: true)
    }
    
}
