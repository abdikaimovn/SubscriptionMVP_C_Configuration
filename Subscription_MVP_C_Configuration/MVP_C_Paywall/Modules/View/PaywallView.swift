//
//  PaywallView.swift
//  Subscription_MVP_C_Configuration
//
//  Created by Нурдаулет on 27.12.2024.
//

public protocol PaywallView: AnyObject {
    func updateLoader(isLoading: Bool)
    func setup(_ paywallCards: [PaywallCardModel])
}
