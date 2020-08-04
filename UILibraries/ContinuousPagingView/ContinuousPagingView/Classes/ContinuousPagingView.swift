//
//  ContinuousPagingView.swift
//  ContinuousPagingView
//
//  Created by Emre Ergün on 26.07.2020.
//

import UIKit

public protocol ContinuousPagingViewDataSource: class {
    func continuousPagingViewNumberOfItems() -> Int
    func continuousPagingViewCellForItem(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell
}

public protocol ContinuousPagingViewDelegate: class {
    func continuousPagingViewDidEndDecelerating(page: Int)
    func continuousPagingViewDidScroll()
    func continuousPagingViewWillDisplay(cell: UICollectionViewCell, at indexPath: IndexPath)
    func continuousPagingViewWillBeginDecelerating(page: Int)
    func continuousPagingViewDidEndScrollingAnimation()
    func continuousPagingViewDidEndDragging(decelerate: Bool)
    func continuousPagingVieWscrollViewWillBeginDragging()
}

public extension ContinuousPagingViewDelegate {
    func continuousPagingViewDidEndDecelerating(page: Int) { }
    func continuousPagingViewDidScroll() { }
    func continuousPagingViewWillDisplay(cell: UICollectionViewCell, at indexPath: IndexPath) { }
    func continuousPagingViewWillBeginDecelerating(page: Int) { }
    func continuousPagingViewDidEndScrollingAnimation() { }
    func continuousPagingViewDidEndDragging(decelerate: Bool) { }
    func continuousPagingVieWscrollViewWillBeginDragging() {}
}

private extension ContinuousPagingView {
    enum Constant {
        static let swipeVelocityThreshold: CGFloat = 0.35
        static let slidePageSizeFactor: CGFloat = 0.35
    }
}

public final class ContinuousPagingView: UIView {
    // MARK: - Public Variables
    public var numberOfItemsPerPage = 3
    public var interItemSpacing: CGFloat = 15
    public var useInterItemSpacingForLeftAndRightInsets = false
    public var showsHorizontalScrollIndicator = true
    
    // MARK: - Public Delegate & DataSource
    public weak var dataSource: ContinuousPagingViewDataSource?
    public weak var delegate: ContinuousPagingViewDelegate?
    
    // MARK: - Private Variables
    private(set) var currentPage = 0
    private var pageOffsets: [Int: CGFloat] = [:]
    private var oldOffsetX: CGFloat = 0
    
    public lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        collection.decelerationRate = .fast
        return collection
    }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        prepareCollectionView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareCollectionView()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        preparePageOffsets()
        collectionView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
        collectionView.layer.masksToBounds = false
    }
    
    private func prepareCollectionView() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func preparePageOffsets() {
        pageOffsets.removeAll()
        for page in 0..<numberOfPages {
            switch pageFitResult(for: page) {
            case .full:
                pageOffsets[page] = pageWidth * CGFloat(page) + (interItemSpacing * CGFloat(page))
            case .partial(let missingCount):
                let defaultOffset = pageWidth * CGFloat(page)
                let finalOffset = defaultOffset - (cellSize.width * CGFloat(missingCount))
                pageOffsets[page] = finalOffset
            }
        }
    }
    
    private var pageWidth: CGFloat {
        if useInterItemSpacingForLeftAndRightInsets {
            return frame.width - 2*interItemSpacing
        } else {
            return frame.width
        }
    }
    
    private var cellSize: CGSize {
        let numberOfInterSpaces = numberOfItemsPerPage - 1
        let interSpaceWidthPerPage = CGFloat(numberOfInterSpaces) * CGFloat(interItemSpacing)
        let cellWidth = (pageWidth - interSpaceWidthPerPage)/CGFloat(numberOfItemsPerPage)
        return CGSize(width: cellWidth, height: frame.height)
    }
    
    private var numberOfPages: Int {
        guard let dataSource = dataSource else { return 0 }
        let result = Double(dataSource.continuousPagingViewNumberOfItems()) / Double(numberOfItemsPerPage)
        let result2 = Int(result.rounded(.up))
        return result2
    }
    
    private func pageFitResult(for page: Int) -> PageFitResult {
        guard let dataSource = dataSource else { fatalError() }
        let totalNumberOfItems = dataSource.continuousPagingViewNumberOfItems()
        let numberOfItemsOnPreviousPages = page * numberOfItemsPerPage
        let remainingItemsCount = totalNumberOfItems - numberOfItemsOnPreviousPages
        if remainingItemsCount > numberOfItemsPerPage {
            return .full
        } else {
            return .partial(missingCount: numberOfItemsPerPage - remainingItemsCount)
        }
    }
    
    private func isScrollEnoughForSliding(scrollAmount: CGFloat) -> Bool {
        return scrollAmount > pageWidth * Constant.slidePageSizeFactor
    }
}

private extension ContinuousPagingView {
    enum PageFitResult {
        case full
        case partial(missingCount: Int)
    }
}

extension ContinuousPagingView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataSource = dataSource else { return 0 }
        return dataSource.continuousPagingViewNumberOfItems()
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dataSource = dataSource else { preconditionFailure() }
        return dataSource.continuousPagingViewCellForItem(for: collectionView, at: indexPath)
    }
}

extension ContinuousPagingView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpacing
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        useInterItemSpacingForLeftAndRightInsets ? UIEdgeInsets(top: 0, left: interItemSpacing, bottom: 0, right: interItemSpacing) : UIEdgeInsets.zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        delegate?.continuousPagingViewWillDisplay(cell: cell, at: indexPath)
    }
}

extension ContinuousPagingView: UIScrollViewDelegate {
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        oldOffsetX = scrollView.contentOffset.x
        delegate?.continuousPagingVieWscrollViewWillBeginDragging()
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.continuousPagingViewDidEndDecelerating(page: currentPage)
    }
    
    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        delegate?.continuousPagingViewWillBeginDecelerating(page: currentPage)
    }

    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        delegate?.continuousPagingViewDidEndScrollingAnimation()
    }

    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        delegate?.continuousPagingViewDidEndDragging(decelerate: decelerate)
    }

    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let direction = ScrollDirection(beginOffset: oldOffsetX, endOffset: scrollView.contentOffset.x)
        let newPage = direction == .right ? min(currentPage.next, numberOfPages-1) : max(currentPage.previous, 0)
        let scrollAmount = abs(scrollView.contentOffset.x-oldOffsetX)
        
        if abs(velocity.x) > Constant.swipeVelocityThreshold {
            targetContentOffset.pointee.x = pageOffsets[newPage] ?? .zero
            currentPage = newPage
        } else {
            if isScrollEnoughForSliding(scrollAmount: scrollAmount) {
                targetContentOffset.pointee.x = scrollView.contentOffset.x
                scrollView.setContentOffset(CGPoint(x: pageOffsets[newPage] ?? .zero, y: 0), animated: true)
                currentPage = newPage
            } else {
                targetContentOffset.pointee.x = scrollView.contentOffset.x
                scrollView.setContentOffset(CGPoint(x: pageOffsets[currentPage] ?? .zero, y: 0), animated: true)
            }
        }
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.continuousPagingViewDidScroll()
    }
}

private extension Int {
    var next: Int {
        self + 1
    }

    var previous: Int {
        self - 1
    }
}

private extension ContinuousPagingView {
    enum ScrollDirection {
        case left
        case right
        
        init(beginOffset: CGFloat, endOffset: CGFloat) {
            self = endOffset > beginOffset ? .right : .left
        }
    }
}
