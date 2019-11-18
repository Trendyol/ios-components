//
//  PresenterInterface.swift
//  Utils
//
//  Created by Ahmet Keskin on 5.11.2019.
//  Copyright © 2019 Trendyol.com. All rights reserved.
//

import Foundation

public protocol PresenterInterface: class {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
}

public extension PresenterInterface {
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewDidAppear() {}
    func viewWillDisappear() {}
    func viewDidDisappear() {}
}
