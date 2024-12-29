//
//  PaywallModuleFactory.swift
//  Subscription_MVP_C_Configuration
//
//  Created by Нурдаулет on 27.12.2024.
//

import UIKit

public struct PaywallModuleFactory {
    public init() {}
    
    public func createPaywall(dependency: PaywallDependency) -> UIViewController {
        let presenter = PaywallPresenterImpl(dependency: dependency)
        let view = PaywallViewController(presenter: presenter)
        presenter.view = view
        return UINavigationController(rootViewController: view)
    }
}
