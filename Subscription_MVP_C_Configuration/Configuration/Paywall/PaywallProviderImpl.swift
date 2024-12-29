//
//  PaywallProviderImpl.swift
//  Subscription_MVP_C_Configuration
//
//  Created by Нурдаулет on 27.12.2024.
//

public final class PaywallProviderImpl {
    private let storage: PaywallStorage
    
    init(storage: PaywallStorage) {
        self.storage = storage
    }
}

// MARK: - PaywallProvider protocol methods
extension PaywallProviderImpl: PaywallProvider {
    public func fetchPaywallCards(completion: ([PaywallCard]) -> Void) {
        completion(storage.getPaywallCards())
    }
}
