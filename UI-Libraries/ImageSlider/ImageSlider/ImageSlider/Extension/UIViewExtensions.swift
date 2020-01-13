//
//  UIViewExtensions.swift
//  EEImageSlider
//
//  Created by Emre Ergün on 10.01.2020.
//  Copyright © 2020 Emre Ergün. All rights reserved.
//

import UIKit

extension UIView {
    enum Anchor {
        case leading(CGFloat)
        case trailing(CGFloat)
        case top(CGFloat)
        case bottom(CGFloat)
        case centerY(CGFloat)
        case centerX(CGFloat)
        case width(CGFloat)
        case height(CGFloat)
    }
    
    @discardableResult
    func embedEdgeToEdge(in containerView: UIView) -> [NSLayoutConstraint] {
        return embed(in: containerView, anchors: [.leading(0), .trailing(0), .bottom(0), .top(0)])
    }
    
    @discardableResult
    func embed(in superView: UIView, anchors: [Anchor], additionalConstraints: [NSLayoutConstraint]? = nil) -> [NSLayoutConstraint] {
        superView.addSubview(self)
        var constraints = additionalConstraints ?? [NSLayoutConstraint]()
        
        anchors.forEach { (anchor) in
            switch anchor {
            case .leading(let value):
                constraints.append(leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: value))
            case .trailing(let value):
                constraints.append(trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: value))
            case .top(let value):
                constraints.append(topAnchor.constraint(equalTo: superView.topAnchor, constant: value))
            case .bottom(let value):
                constraints.append(bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: value))
            case .centerY(let value):
                constraints.append(centerYAnchor.constraint(equalTo: superView.centerYAnchor, constant: value))
            case .centerX(let value):
                constraints.append(centerXAnchor.constraint(equalTo: superView.centerXAnchor, constant: value))
            case .width(let value):
                constraints.append(widthAnchor.constraint(equalToConstant: value))
            case .height(let value):
                constraints.append(heightAnchor.constraint(equalToConstant: value))
            }
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
}
