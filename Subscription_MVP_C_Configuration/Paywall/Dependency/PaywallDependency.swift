//
//  PaywallDependency.swift
//  Subscription_MVP_C_Configuration
//
//  Created by Нурдаулет on 27.12.2024.
//

import Foundation

public struct PaywallDependency {
    public let provider: PaywallProvider
    public let navigationDelegate: PaywallNavigationDelegate
    
    public init(provider: PaywallProvider,
                navigationDelegate: PaywallNavigationDelegate) {
        self.provider = provider
        self.navigationDelegate = navigationDelegate
    }
}
