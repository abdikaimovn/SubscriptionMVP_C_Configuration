//
//  PaywallCardModel.swift
//  Subscription_MVP_C_Configuration
//
//  Created by Нурдаулет on 27.12.2024.
//

import Foundation
import UIKit

public struct PaywallCardModel {
    let title: String
    let promotedSubscriptions: [String]
    let unpromotedSubscriptions: [String]
    let promotion: String?
    let subscriptionImage: UIImage?
    let availableFeatures: [String]
    let unavailableFeatures: [String]
}

extension PaywallCardModel {
    init(_ paywallCard: PaywallCard) {
        title = paywallCard.title
        
        let promotedSubs = paywallCard.subscriptionTypes.filter { $0.isPromoted }
        let unpromotedSubs = paywallCard.subscriptionTypes.filter { !$0.isPromoted }
        
        promotedSubscriptions = promotedSubs.map { $0.formattedString() }
        unpromotedSubscriptions = unpromotedSubs.map { $0.formattedString() }
        
        if let promotionPercentage = paywallCard.promotion {
            promotion = "-\(promotionPercentage.promotionPercentage)%"
        } else {
            promotion = nil
        }
        
        subscriptionImage = UIImage(systemName: paywallCard.subscriptionImageName)
        
        availableFeatures = paywallCard.subscriptionConditions.availableFeatures
        unavailableFeatures = paywallCard.subscriptionConditions.unavailableFeatures
    }
}
