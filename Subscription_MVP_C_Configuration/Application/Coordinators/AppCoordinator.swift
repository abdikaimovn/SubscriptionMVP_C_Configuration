//
//  AppCoordinator.swift
//  Subscription_MVP_C_Configuration
//
//  Created by Нурдаулет on 27.12.2024.
//

import Foundation
import UIKit
import Domain
import Configuration
import Paywall

protocol Coordinator {
    func start()
}

final class AppCoordinator: Coordinator {
    class Dependency {
        let paywallProvider: PaywallProvider
        let paywallStorage: PaywallStorage
        let paywallModuleFactory: PaywallModuleFactory
        
        init(
            paywallProvider: PaywallProvider,
            paywallStorage: PaywallStorage,
            paywallModuleFactory: PaywallModuleFactory
        ) {
            self.paywallProvider = paywallProvider
            self.paywallStorage = paywallStorage
            self.paywallModuleFactory = paywallModuleFactory
        }
    }
    
    var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    
    private let dependency: Dependency
    private let window: UIWindow
    
    init(dependency: Dependency, window: UIWindow) {
        self.dependency = dependency
        self.window = window
    }
    
    func start() {
        showPaywall()
    }

    func showPaywall() {
        let paywallDependency = PaywallDependency(provider: dependency.paywallProvider, navigationDelegate: self)
        window.rootViewController = dependency.paywallModuleFactory.createPaywall(dependency: paywallDependency)
    }
}

extension AppCoordinator: PaywallNavigationDelegate {
    
}
