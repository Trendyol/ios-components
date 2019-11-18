//
//  NibView.swift
//  Utils
//
//  Created by Ahmet Keskin on 7.11.2019.
//  Copyright © 2019 Trendyol.com. All rights reserved.
//

import UIKit

open class NibView: UIView {
    var view: UIView!

    override public init(frame: CGRect) {
        super.init(frame: frame)

        // Setup view from .xib file
        xibSetup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        // Setup view from .xib file
        xibSetup()
    }
}

private extension NibView {

    func xibSetup() {
        backgroundColor = UIColor.clear
        view = loadNib()
        // use bounds not frame or it'll be offset
        view.frame = bounds
        // Adding custom subview on top of our view
        addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view as Any]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view as Any]))
    }
}
