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
    
    @IBAction func minimumZoomScaleSliderChanged(_ sender: UISlider) {
        let minScale = CGFloat(sender.value/5)
        pinchableImageView.minZoomScale = minScale
    }
    
    @IBAction func maximumZoomScaleSliderChanged(_ sender: UISlider) {
        let maxScale = CGFloat(sender.value)
        pinchableImageView.maxZoomScale = maxScale
    }
    
    @IBAction func resetAnimationDurationSliderChanged(_ sender: UISlider) {
        let duration = Double(sender.value/5)
        pinchableImageView.resetAnimationDuration = duration
    }
}
