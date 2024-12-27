//
//  ViewController.swift
//  Subscription_MVP_C_Configuration
//
//  Created by Нурдаулет on 27.12.2024.
//

import UIKit

public final class PaywallViewController: UIViewController {
    // TODO: - UI Components
    
    // MARK: - Dependencies
    private let presenter: PaywallPresenter
    private var cardsModel = [PaywallCardModel]()
    
    // MARK: - Lifecycle
    init(presenter: PaywallPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // TODO: - Private
}

// MARK: PayWallView protocol methods
extension PaywallViewController: PaywallView {
    public func updateLoader(isLoading: Bool) {
        
    }
    
    public func setup(_ paywallCards: [PaywallCardModel]) {
        cardsModel = paywallCards
    }
}

