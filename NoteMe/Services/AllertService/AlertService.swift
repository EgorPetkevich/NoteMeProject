//
//  AlertService.swift
//  NoteMe
//
//  Created by George Popkich on 17.12.23.
//

import UIKit

final class AlertService {
    
    typealias AlertActionhandler = () -> Void
    
    static var current: AlertService = .init()
    
    fileprivate var window: UIWindow?
    
    func showAlert(title: String?,
                   message: String?,
                   cancelTitle: String? = nil,
                   cancelHeldler: AlertActionhandler? = nil,
                   okTitle: String? = nil,
                   okHeldler: AlertActionhandler? = nil) {
        //Build
        let alertVC = buildAlert(title: title,
                                message: message,
                                 cancelTitle: cancelTitle, 
                                 cancelHeldler: cancelHeldler,
                                 okTitle: okTitle,
                                 okHeldler: okHeldler)
        buildWindow()
        //Show
        window?.makeKeyAndVisible()
        window?.rootViewController?.present(alertVC, animated: true)
    }
    
    fileprivate func buildWindow() {
        guard let
                scene = AppCoordinator.windowScene
        else { return }
        
        self.window = UIWindow(windowScene: scene)
        self.window?.windowLevel = .alert
        self.window?.rootViewController = UIViewController()
    }
    
    private func removeWindow() {
        self.window?.resignKey()
        self.window = nil
    }
    
    private func buildAlert(title: String?,
                            message: String?,
                            cancelTitle: String? = nil,
                            cancelHeldler: AlertActionhandler? = nil,
                            okTitle: String? = nil,
                            okHeldler: AlertActionhandler? = nil) -> UIAlertController {
        let alertVC = UIAlertController(title: title,
                                        message: message,
                                        preferredStyle: .alert)
        
        if let cancelTitle {
            let action = UIAlertAction(title: cancelTitle, style: .cancel) { [weak self] _ in
                cancelHeldler?()
                self?.removeWindow()
            }
            alertVC.addAction(action)
        }
        
        if let okTitle {
            let action = UIAlertAction(title: okTitle, style: .default) { [weak self] _ in
                okHeldler?()
                self?.removeWindow()
            }
            alertVC.addAction(action)
        }
        
        return alertVC
    }
    
}

extension UIAlertController {
    
    func show() {
        let alertService = AlertService.current
        AlertService.current.buildWindow()
        
        alertService.window?.makeKeyAndVisible()
        alertService.window?.rootViewController?.present(self, animated: true)
    }
    
}
