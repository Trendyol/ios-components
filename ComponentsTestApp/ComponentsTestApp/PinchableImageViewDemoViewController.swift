//
//  PinchableImageViewDemoViewController.swift
//  ComponentsTestApp
//
//  Created by Emre Ergün on 14.01.2020.
//  Copyright © 2020 Emre Ergün. All rights reserved.
//

import PinchableImageView
import UIKit

final class PinchableImageViewDemoViewController: UIViewController {
    @IBOutlet private weak var pinchableImageView: PinchableImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pinchable ImageView"
    }
}
