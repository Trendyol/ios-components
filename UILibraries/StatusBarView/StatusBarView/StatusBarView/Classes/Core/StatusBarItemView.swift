//
//  StatusBarItemView.swift
//  StatusBarView
//
//  Created by Ersen Tekin on 4.05.2020.
//  Copyright © 2020 Ersen Tekin. All rights reserved.
//

import UIKit

extension StatusBarItemView {
    private enum Constant {
        static let maskInset: CGFloat = 4.0
        static let maskShadowOpacity: Float = 1.0
        static let maskShadowRadius: CGFloat = 3.0
    }
}

public class StatusBarItemView: UIView {
    private weak var containerView: UIView!
    @IBOutlet private weak var outerCircleView: UIView!
    @IBOutlet private weak var innerCircleView: UIView!
    @IBOutlet private weak var shadowCircleView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func configure(title: String, color: UIColor, isActive: Bool) {
        titleLabel.textColor = color
        titleLabel.text = title
        
        if isActive {
            innerCircleView.backgroundColor = color
            outerCircleView.backgroundColor = .white
            shadowCircleView.backgroundColor = color
            
            let maskLayer = CAGradientLayer()
            maskLayer.frame = shadowCircleView.bounds
            maskLayer.shadowRadius = Constant.maskShadowRadius
            let height = shadowCircleView.bounds.height
            let path = CGPath(roundedRect: shadowCircleView.bounds.insetBy(dx: height/4, dy: height/4),
                              cornerWidth: height/8,
                              cornerHeight: height/8,
                              transform: nil)
            maskLayer.shadowPath = path
            maskLayer.shadowOpacity = Constant.maskShadowOpacity
            maskLayer.shadowOffset = CGSize.zero
            maskLayer.shadowColor = UIColor.white.cgColor
            shadowCircleView.layer.mask = maskLayer
        } else {
            outerCircleView.backgroundColor = color
            innerCircleView.backgroundColor = .white
            shadowCircleView.backgroundColor = .clear
        }
    }
    
    // MARK: - Private
    private func setup() {
        backgroundColor = UIColor.clear
        let nibView = loadNib()
        containerView = nibView
        containerView.frame = bounds
        addSubview(containerView)

        containerView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": nibView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": nibView]))

        titleLabel.lineBreakMode = .byWordWrapping
    }
    
    private func loadNib() -> UIView {
        #if SWIFT_PACKAGE
        let bundle = Bundle.module
        #else
        let bundle = Bundle(for: type(of: self))
        #endif
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}
