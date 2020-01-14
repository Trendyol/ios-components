//
//  ImageSliderView.swift
//  ProductDetail
//
//  Created by Emre Ergün on 7.11.2019.
//  Copyright © 2019 Trendyol.com. All rights reserved.
//

import UIKit

public protocol ImageSliderViewInterface: class {
    var scrollViewContentOffsetXPos: Double { get }
    var scrollViewWidth: Double { get }
    var presentedImageView: UIImageView? { get }

    func reloadCollectionView()
    func prepareCollectionView()
    func prepareSubviews()
    func scroll(to xOffset: Double, animate: Bool)
    func preparePageControl(numberOfPages: Int)
    func setPager(to page: Int)
    func setPageControllerHidden(hide: Bool)
    func showThumbnailImage(_ image: UIImage?)
    func hideThumbnailImage()
}

public final class ImageSliderView: UIView {

    // MARK: Properties
    public var presenter: ImageSliderViewPresenterInterface! {
        didSet {
            presenter.load()
        }
    }

    // MARK: Outlets
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    private lazy var pager: ImageSliderPagerView = {
        return ImageSliderPagerView(frame: .zero)
    }()
    
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let gradientLayer = CAGradientLayer()
    private var gradientView: UIView?

    // Initialization
    override public init(frame: CGRect) {
        super.init(frame: frame)
        prepareUI()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareUI()
    }

    private func prepareUI() {
        thumbnailImageView.contentMode = .scaleAspectFill
    }
}

extension ImageSliderView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.presentedImageUrlsCount ?? 0
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageSliderCollectionViewCell", for: indexPath) as? ImageSliderCollectionViewCell else { fatalError() }
        let cellPresenter = ImageSliderCollectionViewCellPresenter(imageUrl: presenter!.presentedImageUrls[indexPath.row], view: cell)
        cell.presenter = cellPresenter
        return cell
    }
}

extension ImageSliderView: ImageSliderViewInterface {
    public func setPageControllerHidden(hide: Bool) {
        pager.isHidden = hide
    }

    public func showThumbnailImage(_ image: UIImage?) {
        thumbnailImageView.image = image
        thumbnailImageView.isHidden = false
    }

    public func hideThumbnailImage() {
        thumbnailImageView.isHidden = true
    }

    public var presentedImageView: UIImageView? {
        guard let presenter = presenter else { return nil }
        guard let cell = collectionView.cellForItem(at: IndexPath(row: presenter.currentInnerPageIndex, section: 0)) as? ImageSliderCollectionViewCell else { return nil }
        return cell.contentImageView
    }

    public func preparePageControl(numberOfPages: Int) {
        pager.pageControl.numberOfPages = numberOfPages
    }

    public func setPager(to page: Int) {
        pager.pageControl.currentPage = page
    }

    public func scroll(to xOffset: Double, animate: Bool) {
        collectionView.setContentOffset(CGPoint(x: CGFloat(xOffset), y: collectionView.contentOffset.y), animated: animate)
    }

    public var scrollViewContentOffsetXPos: Double {
        return Double(collectionView.contentOffset.x)
    }

    public var scrollViewWidth: Double {
        return Double(collectionView.frame.width)
    }

    public func reloadCollectionView() {
        collectionView.reloadData()
    }

    public func prepareCollectionView() {
        collectionView.register(ImageSliderCollectionViewCell.self, forCellWithReuseIdentifier: "ImageSliderCollectionViewCell")
        collectionView.isPagingEnabled = true
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        collectionView.setCollectionViewLayout(flowLayout, animated: false)
        
        pager.layoutIfNeeded()
    }
    
    public func prepareSubviews() {
        collectionView.embedEdgeToEdge(in: self)
        pager.embed(in: self, anchors: [.centerX(0), .bottom(-15), .height(19)])
        thumbnailImageView.embedEdgeToEdge(in: self)
        layoutIfNeeded()
    }
}

extension ImageSliderView: UIScrollViewDelegate {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard collectionView == scrollView else { return }
        presenter.scrollViewDidEndDecelerating()
    }
}

extension ImageSliderView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}
