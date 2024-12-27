//
//  ViewController.swift
//  Subscription_MVP_C_Configuration
//
//  Created by Нурдаулет on 27.12.2024.
//

import UIKit
import SnapKit

public final class PaywallViewController: UIViewController {
    // TODO: - UI Components
    private let paywallTitle: UILabel = {
        let label = UILabel()
        label.text = "An essential tool for content creators and professionals."
        label.font = .systemFont(ofSize: 28.0, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var cardCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let slider = UICollectionView(frame: .zero, collectionViewLayout: layout)
        slider.showsHorizontalScrollIndicator = false
        slider.showsVerticalScrollIndicator = false
        slider.isPagingEnabled = true
        slider.delegate = self
        slider.dataSource = self
        slider.backgroundColor = .clear
        slider.register(CardCollectionCell.self, forCellWithReuseIdentifier: CardCollectionCell.typeName)
        return slider
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .darkGray
        return pageControl
    }()
    
    private let subscribeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Subscribe now", for: .normal)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 12
        button.layer.cornerCurve = .continuous
        return button
    }()
    
    private let loaderView: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.style = .large
        loader.backgroundColor = .white
        loader.color = .gray
        loader.isHidden = true
        return loader
    }()
    
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
        setupView()
        setupConstraints()
        
        presenter.onLoadPaywallCards()
    }
}

// MARK: - Private
private extension PaywallViewController {
    func setupView() {
        view.backgroundColor = .white
    }
    
    func setupConstraints() {
        view.addSubview(paywallTitle)
        paywallTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        view.addSubview(cardCollectionView)
        cardCollectionView.snp.makeConstraints { make in
            make.top.equalTo(paywallTitle.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(cardCollectionView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        view.addSubview(subscribeButton)
        subscribeButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(28)
            make.top.equalTo(pageControl.snp.bottom).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
            make.height.equalTo(48)
        }
        
        view.addSubview(loaderView)
        loaderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: PayWallView protocol methods
extension PaywallViewController: PaywallView {
    public func updateLoader(isLoading: Bool) {
        if isLoading {
            loaderView.startAnimating()
            loaderView.isHidden = false
        } else {
            loaderView.stopAnimating()
            loaderView.isHidden = true
        }
    }
    
    public func setup(_ paywallCards: [PaywallCardModel]) {
        cardsModel = paywallCards
        pageControl.numberOfPages = cardsModel.count
        cardCollectionView.reloadData()
    }
}

extension PaywallViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cardsModel.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionCell.typeName, for: indexPath) as! CardCollectionCell
        cell.configure(cardsModel[indexPath.row])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
