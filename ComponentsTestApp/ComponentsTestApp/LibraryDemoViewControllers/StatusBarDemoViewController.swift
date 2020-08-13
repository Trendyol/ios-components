//
//  StatusBarDemoViewController.swift
//  ComponentsTestApp
//
//  Created by Ersen Tekin on 4.05.2020.
//  Copyright © 2020 Emre Ergün. All rights reserved.
//

import StatusBarView
import UIKit

final class StatusBarDemoViewController: UIViewController {
    @IBOutlet private weak var statusBarView: StatusBarView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "StatusBarView"

        let titles = [
            "Received",
            "Preparing",
            "Shipped",
            "Completed"
        ]
        statusBarView.configure(titles: titles, activeIndex: 1, activeColor: .systemGreen, passiveColor: .lightGray)
    }
}
