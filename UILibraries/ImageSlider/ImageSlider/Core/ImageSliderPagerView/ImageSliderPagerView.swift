//
//  ImageSliderPagerView.swift
//  ProductDetail
//
//  Created by Emre Ergün on 8.11.2019.
//  Copyright © 2019 Trendyol.com. All rights reserved.
//

import UIKit

private extension ImageSliderPagerView {
    enum Constant {
        enum UI {
            static let cornerRadius: CGFloat = 10
            static let backgroundAlpha: CGFloat = 0.3
            static let pageControlHorizontalInset: CGFloat = 10
            static let pageControlVerticalInset: CGFloat = 6
        }
    }
}

final class ImageSliderPagerView: UIView {
    lazy var pageControl: UIPageControl = {
        return UIPageControl()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        layer.cornerRadius = Constant.UI.cornerRadius
        layer.masksToBounds = true
        backgroundColor = UIColor.black.withAlphaComponent(Constant.UI.backgroundAlpha)
        preparePageControl()
    }
    
    private func preparePageControl() {
        pageControl.embed(in: self, anchors: [
            .leading(Constant.UI.pageControlHorizontalInset),
            .trailing(-Constant.UI.pageControlHorizontalInset),
            .top(Constant.UI.pageControlVerticalInset),
            .bottom(-Constant.UI.pageControlVerticalInset)]
        )
    }
}
