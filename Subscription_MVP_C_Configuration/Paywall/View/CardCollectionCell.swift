//
//  CardCollectionCell.swift
//  Subscription_MVP_C_Configuration
//
//  Created by Нурдаулет on 27.12.2024.
//

import UIKit
import SnapKit

public final class CardCollectionCell: UICollectionViewCell {
    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28.0, weight: .bold)
        label.textColor = [UIColor.systemRed, UIColor.systemGreen, UIColor.systemPink, UIColor.systemBlue, UIColor.systemTeal, UIColor.systemOrange, UIColor.systemMint].randomElement()!
        return label
    }()
    
    private let pricesStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 5
        return stack
    }()
    
    private let promotionView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.isHidden = true
        view.layer.cornerRadius = 5
        view.layer.cornerCurve = .continuous
        return view
    }()
    
    private let promotionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .semibold)
        label.textColor = .white
        label.isHidden = true
        return label
    }()
    
    private let cardImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let featuresStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 10
        return stack
    }()
    
    // MARK: - Lifecycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    func configure(_ cardModel: PaywallCardModel) {
        titleLabel.text = cardModel.title
         
        cardModel.promotedSubscriptions.forEach {
            pricesStackView.addArrangedSubview(priceLabelFactory(true, $0))
        }
        
        cardModel.unpromotedSubscriptions.forEach {
            pricesStackView.addArrangedSubview(priceLabelFactory(false, $0))
        }
        
        if let promotion = cardModel.promotion {
            promotionView.isHidden = false
            promotionLabel.isHidden = false
            promotionLabel.text = promotion
        }
        
        cardImage.image = cardModel.subscriptionImage
        cardImage.tintColor = titleLabel.textColor
        
        cardModel.availableFeatures.forEach { feature in
            featuresStackView.addArrangedSubview(featureViewFactory(true, feature))
        }
        
        cardModel.unavailableFeatures.forEach { feature in
            featuresStackView.addArrangedSubview(featureViewFactory(false, feature))
        }
        
        setupConstraints()
    }
    
    public override func prepareForReuse() {
        pricesStackView.arrangedSubviews.forEach { 
            $0.removeFromSuperview()
        }
        
        featuresStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
    }
}

private extension CardCollectionCell {
    func setupView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentView.layer.shadowRadius = 8
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
            make.center.equalToSuperview()
        }
    }
    
    func setupConstraints() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        contentView.addSubview(pricesStackView)
        pricesStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        contentView.addSubview(promotionView)
        promotionView.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(pricesStackView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalTo(pricesStackView.snp.centerY)
        }
        
        promotionView.addSubview(promotionLabel)
        promotionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview().inset(2)
            make.center.equalToSuperview()
        }
        
        contentView.addSubview(cardImage)
        cardImage.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(pricesStackView.snp.bottom).offset(30)
            make.size.equalTo(70)
        }
        
        contentView.addSubview(featuresStackView)
        featuresStackView.setContentHuggingPriority(.required, for: .horizontal)
        featuresStackView.snp.makeConstraints { make in
            make.top.equalTo(cardImage.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.lessThanOrEqualToSuperview().inset(20)
        }
    }
    
    func priceLabelFactory(_ isPromoted: Bool, _ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.textColor = isPromoted ? .darkGray : .gray
        label.font = isPromoted ? .systemFont(ofSize: 16.0, weight: .bold) : .systemFont(ofSize: 12.0)
        return label
    }
    
    // MARK: Caution!!! HARDCODED :D
    func featureViewFactory(_ isAvailable: Bool, _ featureText: String) -> UIView {
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 10
        
        let signLabel = UILabel()
        signLabel.text = isAvailable ? "✅" : "❌"
        signLabel.font = .systemFont(ofSize: 14.0)
        
        let featureTextLabel = UILabel()
        featureTextLabel.numberOfLines = 0
        featureTextLabel.textColor = isAvailable ? .black : .gray
        featureTextLabel.font = .systemFont(ofSize: 14.0)
        featureTextLabel.text = featureText
        
        horizontalStack.addArrangedSubview(signLabel)
        horizontalStack.addArrangedSubview(featureTextLabel)
        return horizontalStack
    }
}

