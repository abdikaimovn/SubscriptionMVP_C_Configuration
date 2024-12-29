//
//  PaywallCard.swift
//  Subscription_MVP_C_Configuration
//
//  Created by Нурдаулет on 27.12.2024.
//

public struct PaywallCard {
    let title: String
    let subscriptionTypes: [Subscription]
    let promotion: Promotion?
    let subscriptionImageName: String
    let subscriptionConditions: SubscriptionConditions
}

public struct Subscription {
    let price: Double
    let currency: Character
    let isPromoted: Bool
    let period: SubscriptionPeriod
}

extension Subscription {
    func formattedString() -> String {
        switch period {
        case .month:
            return "\(currency)\(price) / month"
        case .annual:
            return "\(currency)\(price) billed annualy"
        }
    }
}

public struct Promotion {
    let promotionPercentage: Int
}

public enum SubscriptionPeriod: String {
    case month
    case annual
}

public struct SubscriptionConditions {
    let availableFeatures: [String]
    let unavailableFeatures: [String]
}
