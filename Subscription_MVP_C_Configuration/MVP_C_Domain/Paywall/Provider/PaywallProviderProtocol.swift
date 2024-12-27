//
//  PaywallProviderProtocol.swift
//  Subscription_MVP_C_Configuration
//
//  Created by Нурдаулет on 27.12.2024.
//

import Foundation

public protocol PaywallProvider {
    func fetchPaywallCards(completion: ([PaywallCard]) -> Void)
}
