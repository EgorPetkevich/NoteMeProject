//
//  AppCoordinator.swift
//  NoteMe
//
//  Created by George Popkich on 21.11.23.
//

import UIKit

@available(iOS 13.4, *)
final class AppCoordinator: Coordinator {
    
    private let container: Container
    private let windowManager: WindowManager
    
    init(container: Container) {
        self.container = container
        self.windowManager = container.resolve()
    }
    
    func startApp() {
        //FIXME: - TEST CODE
//        open module
//        ParametersHelper.set(.onboardDidFinish, value: false)
//        ParametersHelper.set(.authenticatied, value: false)
//        if !ParametersHelper.get(.authenticatied) {
//            openAuthModule()
//        }else if !ParametersHelper.get(.onboardDidFinish) {
//            openOnboardingModule()
//        }else {
//            //open mainApp
//            openMainApp()
//        }
//        openAuthModule()
        openMainApp()
       
        
    }
    
    private func openAuthModule() {
        let coordinator = LoginCoordinator(container: container)
        children.append(coordinator)
        
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll {$0 == coordinator}
            self?.startApp()
        }
        let vc = coordinator.start()
        
        let window = windowManager.get(type: .main)
        window.rootViewController = vc
        windowManager.show(type: .main)
    }
    
    private func openOnboardingModule() {
        let coordinator = OnboardFirstStepCoordinator()
        children.append(coordinator)
        
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll {coordinator == $0}
            self?.startApp()
        }
        
        let vc = coordinator.start()
        
        let window = windowManager.get(type: .main)
        window.rootViewController = vc
        windowManager.show(type: .main)
    }
    
    private func openMainApp () {
        let coordinator = MainTabBarCoordinator(container: container)
        children.append(coordinator)
        
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll {coordinator == $0}
            self?.startApp()
        }
        
        let vc = coordinator.start()
        
        let window = windowManager.get(type: .main)
        window.rootViewController = vc
        windowManager.show(type: .main)
    }
    
}
