//
//  SceneDelegate.swift
//  Subscription_MVP_C_Configuration
//
//  Created by Нурдаулет on 27.12.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Test
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        
        let paywallStorage = PaywallStorageImpl()
        let paywallProvider = PaywallProviderImpl(storage: paywallStorage)
        let paywallModuleFactory = PaywallModuleFactory()
        
        appCoordinator = AppCoordinator(
            dependency: AppCoordinator.Dependency(
                paywallProvider: paywallProvider,
                paywallStorage: paywallStorage,
                paywallModuleFactory: paywallModuleFactory
            ),
            window: window ?? UIWindow() )
        appCoordinator?.start()
    }
}

