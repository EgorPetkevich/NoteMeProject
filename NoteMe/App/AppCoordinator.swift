//
//  AppCoordinator.swift
//  NoteMe
//
//  Created by George Popkich on 21.11.23.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    private var window: UIWindow
    
    init(scene: UIWindowScene) {
        self.window = UIWindow(windowScene: scene)
    }
    
    func startApp() {
        //FIXME: - TEST CODE
        //open module
        ParametersHelper.set(.onboardDidFinish, value: false)
        ParametersHelper.set(.authenticatied, value: true)
        if !ParametersHelper.get(.authenticatied) {
            openAuthModule()
        }else if !ParametersHelper.get(.onboardDidFinish) {
            openOnboardingModule()
        }else {
            //open mainApp
            openMainApp()
        }
        
    }
    
    private func openAuthModule() {
        let coordinator = LoginCoordinator()
        children.append(coordinator)
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll {$0 == coordinator}
            self?.startApp()
        }
        let vc = coordinator.start()
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
    
    private func openOnboardingModule() {
        let coordinator = OnboardFirstStepCoordinator()
        children.append(coordinator)
        
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll {coordinator == $0}
            self?.startApp()
        }
        
        let vc = coordinator.start()
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
    
    private func openMainApp () {
        let coordinator = TabBarCoordinator()
        children.append(coordinator)
        
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll {coordinator == $0}
        }
        
        let vc = coordinator.start()
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
    
}
