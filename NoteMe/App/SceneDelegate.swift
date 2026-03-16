//
//  SceneDelegate.swift
//  NoteMe
//
//  Created by George Popkich on 24.10.23.
//

import UIKit

@available(iOS 13.4, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else {return}
        
        let container = ContainerRegistrator.makeContainer()
        container.register({ WindowManager(scene: windowScene) })
        appCoordinator = AppCoordinator(container: container)
        appCoordinator?.startApp()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}


    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
           handleDeepLink(url)
    }
    
    func handleDeepLink(_ url: URL) {
        guard url.scheme == "myapp" else { return }

        switch url.host {
        case "profile":
            if let id = url.pathComponents.dropFirst().first {
//                openProfile(id: id)
            }

        case "settings":
//           openSettings()
            print("Settings")

        default:
            break
        }
    }
    func scene(
        _ scene: UIScene,
        continue userActivity: NSUserActivity
    ) {
        guard let url = userActivity.webpageURL else { return }
        handleDeepLink(url)
    }
}


