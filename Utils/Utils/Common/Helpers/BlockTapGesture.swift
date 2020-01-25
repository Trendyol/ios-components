//
//  BlockTapGesture.swift
//  Utils
//
//  Created by Ahmet Keskin on 10.11.2019.
//  Copyright © 2019 Trendyol.com. All rights reserved.
//

import UIKit

class BlockTapGesture: UITapGestureRecognizer {
    private var tapAction: ((UITapGestureRecognizer) -> Void)?

    public override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }

    public convenience init(tapCount: Int = 1, fingerCount: Int = 1, action: ((UITapGestureRecognizer) -> Void)?) {
        self.init()
        self.numberOfTapsRequired = tapCount
        self.numberOfTouchesRequired = fingerCount
        self.tapAction = action
        self.addTarget(self, action: #selector(BlockTapGesture.didTap(_:)))
    }

    @objc open func didTap(_ tap: UITapGestureRecognizer) {
        tapAction?(tap)
    }
}
