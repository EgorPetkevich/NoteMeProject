//
//  HomeCoordinator.swift
//  NoteMe
//
//  Created by George Popkich on 18.12.23.
//

import UIKit
import Storage

final class HomeCoordinator: Coordinator {
    
    private var rootVC: UIViewController?
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    override func start() -> UIViewController {
        let vc = HomeAssembler.make(coordinator: self, container: container)
        rootVC = vc
        return vc
    }
    
}

extension HomeCoordinator: HomeCoordinatorProtocol {
    
    func showMenu(sender: UIView, delegate: MenuPopoverDelegate) {
        let menu = MenuPopoverBuilder.buildEditMenu(delegate: delegate,
                                                   sourseView: sender)
        rootVC?.present(menu, animated: true)
    }
    
    func startEdite(date dto: any DTODescription) {
        switch dto {
        case is DateNotificationDTO: 
            openEditDateNotification(dto: dto as! DateNotificationDTO)
        case is LocationNotificationDTO:
            openEditLocationNotification(dto: dto as! LocationNotificationDTO)
        case is TimerNotificationDTO:
            openEditTimerNotification(dto: dto as! TimerNotificationDTO)
        default:
            return
        }
    }
    
    func openEditDateNotification(dto: DateNotificationDTO) {
        let coordinator = DateNotificationCoordinator(container: container, dto)
        children.append(coordinator)
        
        let vc = coordinator.start()
        
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll {coordinator == $0}
            vc.dismiss(animated: true)
        }
        
        vc.modalPresentationStyle = .fullScreen
        rootVC?.present(vc, animated: true)
    }
    
    func openEditLocationNotification(dto: LocationNotificationDTO) {
        let coordinator = LocationNotificationCoordinator(container: container, dto)
        children.append(coordinator)
        
        let vc = coordinator.start()
        
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll {coordinator == $0}
            vc.dismiss(animated: true)
        }
        
        vc.modalPresentationStyle = .fullScreen
        rootVC?.present(vc, animated: true)
    }
    
    func openEditTimerNotification(dto: TimerNotificationDTO) {
        let coordinator = TimerNotificationCoordinator(container: container, dto)
        children.append(coordinator)
        
        let vc = coordinator.start()
        
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll {coordinator == $0}
            vc.dismiss(animated: true)
        }
        
        vc.modalPresentationStyle = .fullScreen
        rootVC?.present(vc, animated: true)
    }
    
}
