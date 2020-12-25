//
//  StatusBarView.swift
//  StatusBarView
//
//  Created by Ersen Tekin on 4.05.2020.
//  Copyright © 2020 Ersen Tekin. All rights reserved.
//

import UIKit

extension StatusBarView {
    private enum Constant {
        static let lineHeight: CGFloat = 2.0
    }
}

public class StatusBarView: UIView {
    @IBOutlet private weak var statusesStackView: UIStackView!
    @IBOutlet private weak var linesStackView: UIStackView!
    @IBOutlet private weak var linesStackViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var linesStackViewTrailingConstraint: NSLayoutConstraint!
    private weak var containerView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    /**
    Configures the view with the given parameters.

    - Parameters:
       - titles: Titles of the status bar items
       - activeIndex: The last active index from 0 to (N - 1) (N: number of titles)
       - activeColor: color of the active items
       - passiveColor: color of the passive items
    */
    public func configure(titles: [String],
                          activeIndex: Int = 0,
                          activeColor: UIColor = .systemGreen,
                          passiveColor: UIColor = .systemGray) {
        removeAllSubviews(of: statusesStackView)
        removeAllSubviews(of: linesStackView)
        
        var isLastActiveItem = false
        for (index, title) in titles.enumerated() {
            let selectedColor = isLastActiveItem ? passiveColor : activeColor
            let itemView = StatusBarItemView()
            itemView.configure(title: title, color: selectedColor, isActive: !isLastActiveItem)
            statusesStackView.addArrangedSubview(itemView)
            
            if index > 0 {
                let lineWidth = statusesStackView.bounds.width / CGFloat(titles.count)
                let lineView = createLineView(color: selectedColor, width: lineWidth)
                linesStackView.addArrangedSubview(lineView)
            }
            
            if index == activeIndex {
                isLastActiveItem = true
            }
        }
        guard titles.count > 0 else { return }
        
        let statusesWidth = bounds.width - (CGFloat(titles.count - 1) * statusesStackView.spacing)
        let linesSpacing = (statusesWidth / CGFloat(titles.count)) / 2
        linesStackViewLeadingConstraint.constant = linesSpacing
        linesStackViewTrailingConstraint.constant = linesSpacing
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
    
    private func removeAllSubviews(of stackView: UIStackView) {
        for subview in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }
    
    private func createLineView(color: UIColor, width: CGFloat) -> UIView {
        let lineView = UIView()
        lineView.heightAnchor.constraint(equalToConstant: Constant.lineHeight).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: width).isActive = true
        lineView.backgroundColor = color
        return lineView
    }
}
