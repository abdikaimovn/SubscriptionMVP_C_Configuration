//
//  PaywallDataSource.swift
//  Subscription_MVP_C_Configuration
//
//  Created by Нурдаулет on 27.12.2024.
//

public final class PaywallStorageImpl {
    private var data = [PaywallCard]()
    
    init() {
        loadData()
    }
}

// MARK: - PaywallStorage protocol methods
extension PaywallStorageImpl: PaywallStorage {
    public func getPaywallCards() -> [PaywallCard] {
        data
    }
}

// MARK: - Mock
extension PaywallStorageImpl {
    func loadData() {
        data = [
            // Standart Subscription
            PaywallCard(
                title: "Standart",
                subscriptionTypes: [
                    Subscription(
                        price: 3.99,
                        currency: "$",
                        isPromoted: true,
                        period: .month
                    ),
                    Subscription(
                        price: 39.99,
                        currency: "$",
                        isPromoted: false,
                        period: .annual
                    )
                ],
                promotion: Promotion(promotionPercentage: 10),
                subscriptionImageName: "mic.square.fill",
                subscriptionConditions: SubscriptionConditions(
                    availableFeatures: [
                        "Basic audio-to-text transcription",
                    ],
                    unavailableFeatures: [
                        "Real-time transcription",
                        "Support for multiple languages",
                        "Advanced accuracy improvements"
                    ]
                )
            ),
            
            // Premium Subscription
            PaywallCard(
                title: "Premium",
                subscriptionTypes: [
                    Subscription(
                        price: 9.99,
                        currency: "$",
                        isPromoted: true,
                        period: .month
                    ),
                    Subscription(
                        price: 99.99,
                        currency: "$",
                        isPromoted: false,
                        period: .annual
                    )
                ],
                promotion: Promotion(promotionPercentage: 20),
                subscriptionImageName: "text.word.spacing",
                subscriptionConditions: SubscriptionConditions(
                    availableFeatures: [
                        "Enhanced audio-to-text transcription with improved accuracy",
                        "Multiple language support",
                        "Basic real-time transcription feature"
                    ],
                    unavailableFeatures: [
                        "Priority transcription speed for large files"
                    ]
                )
            ),
            
            // VIP Subscription
            PaywallCard(
                title: "VIP",
                subscriptionTypes: [
                    Subscription(
                        price: 19.99,
                        currency: "$",
                        isPromoted: true,
                        period: .month
                    ),
                    Subscription(
                        price: 199.99,
                        currency: "$",
                        isPromoted: false,
                        period: .annual
                    )
                ],
                promotion: Promotion(promotionPercentage: 30),
                subscriptionImageName: "flame.fill",
                subscriptionConditions: SubscriptionConditions(
                    availableFeatures: [
                        "Access to all audio-to-text features",
                        "Unlimited file length for transcription",
                        "Real-time transcription with advanced accuracy",
                        "Custom punctuation and formatting options"
                    ],
                    unavailableFeatures: []
                )
            )
        ]
        
    }
}
