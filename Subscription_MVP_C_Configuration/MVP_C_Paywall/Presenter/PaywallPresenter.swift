//
//  PaywallPresenter.swift
//  Subscription_MVP_C_Configuration
//
//  Created by Нурдаулет on 27.12.2024.
//

import Foundation

public protocol PaywallPresenter {
    var view: PaywallView? { get set }
    func onLoadPaywallCards()
}
