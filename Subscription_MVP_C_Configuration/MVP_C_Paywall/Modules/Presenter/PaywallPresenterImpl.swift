//
//  PaywallPresenterImpl.swift
//  Subscription_MVP_C_Configuration
//
//  Created by Нурдаулет on 27.12.2024.
//

import Foundation

public protocol PaywallNavigationDelegate: AnyObject {
    
}

public final class PaywallPresenterImpl {
    weak public var view: PaywallView?
    
    private let provider: PaywallProvider
    private weak var navigationDelegate: PaywallNavigationDelegate?
    
    init(dependency: PaywallDependency) {
        provider = dependency.provider
        navigationDelegate = dependency.navigationDelegate
    }
}

extension PaywallPresenterImpl: PaywallPresenter {
    public func onLoadPaywallCards() {
        view?.updateLoader(isLoading: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.provider.fetchPaywallCards { cards in
                self.view?.updateLoader(isLoading: false)
                let paywallCards = cards.map { PaywallCardModel($0)}
                self.view?.setup(paywallCards)
            }
        }
    }
}
