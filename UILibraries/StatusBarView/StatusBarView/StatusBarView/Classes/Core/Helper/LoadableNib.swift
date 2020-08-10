//
//  LoadableNib.swift
//  StatusBarView
//
//  Created by Barış Uyar on 7.08.2020.
//  Copyright © 2020 Ersen Tekin. All rights reserved.
//

import UIKit

public protocol LoadableNib: class {
    static var name: String { get }
}

public extension LoadableNib where Self: UIView {
    static var name: String {
        return String(describing: Self.self)
    }
}
