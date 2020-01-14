//
//  ImageSliderViewPresenter.swift
//  ProductDetail
//
//  Created by Emre Ergün on 8.11.2019.
//  Copyright © 2019 Trendyol.com. All rights reserved.
//

import Foundation

public protocol ImageSliderViewPresenterInterface: class {
    var presentedImageUrls: [String] { get }
    var presentedImageUrlsCount: Int { get }
    var currentInnerPageIndex: Int { get }

    func load()
    func scrollViewDidEndDecelerating()
}

private extension ImageSliderViewPresenter {
    enum Constant {
        static let pageControlMinimumVisibleImageCount = 2
    }
}

public final class ImageSliderViewPresenter {
    weak var view: ImageSliderViewInterface?
    private let imageUrls: [String]
    private let loopingEnabled: Bool

    // MARK: Initialization
    public init(imageUrls: [String], loopingEnabled: Bool = true, view: ImageSliderViewInterface?) {
        self.view = view
        self.imageUrls = imageUrls
        self.loopingEnabled = loopingEnabled

        view?.setPageControllerHidden(hide: imageUrls.count < Constant.pageControlMinimumVisibleImageCount)
        view?.hideThumbnailImage()
    }

    // MARK: Private Helper Computed Variables
    private var innerPageIndex: Int {
        guard let view = view else { return 0 }
        return Int(view.scrollViewContentOffsetXPos/view.scrollViewWidth)
    }

    lazy public var presentedImageUrls: [String] = {
        return manipulateImageUrls(imageUrls)
    }()

    // MARK: Private Helper Methods
    private func manipulateImageUrls(_ imageUrls: [String]) -> [String] {
        guard imageUrls.count > 1 else { return imageUrls }
        guard loopingEnabled else { return imageUrls }
        
        guard let firstElement = imageUrls.first, let lastElement = imageUrls.last else { return imageUrls }

        var transformedArray = [String]()
        transformedArray.append(lastElement)
        transformedArray.append(contentsOf: imageUrls)
        transformedArray.append(firstElement)

        return transformedArray
    }

    private func handleLoopingAfterDeceleration() {
        guard loopingEnabled else { return }
        guard let view = view, imageUrls.count > 1 else { return }

        if innerPageIndex == 0 {
            let destinationIndex = imageUrls.count
            let destinationWidth = view.scrollViewWidth * Double(destinationIndex)
            view.scroll(to: destinationWidth, animate: false)

        } else if innerPageIndex == presentedImageUrlsCount - 1 {
            let destinationIndex = 1
            let destinationWidth = view.scrollViewWidth * Double(destinationIndex)
            view.scroll(to: destinationWidth, animate: false)
        }
    }

    private func handlePager() {
        guard imageUrls.count > 1 else { return }
        view?.setPager(to: innerPageIndex - (loopingEnabled ? 1:0))
    }
}

extension ImageSliderViewPresenter: ImageSliderViewPresenterInterface {
    public var currentInnerPageIndex: Int {
        return innerPageIndex
    }

    public func scrollViewDidEndDecelerating() {
        handleLoopingAfterDeceleration()
        handlePager()
    }

    public var presentedImageUrlsCount: Int {
        return presentedImageUrls.count
    }

    public func load() {
        view?.prepareCollectionView()
        view?.reloadCollectionView()
        view?.prepareSubviews()

        if let view = view {
            if loopingEnabled {
                view.scroll(to: view.scrollViewWidth, animate: false)
            }
            view.preparePageControl(numberOfPages: imageUrls.count)
            view.setPager(to: 0)
        }
    }
}
