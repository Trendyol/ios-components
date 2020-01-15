//
//  ImageSliderDemoViewController.swift
//  ComponentsTestApp
//
//  Created by Emre Ergün on 14.01.2020.
//  Copyright © 2020 Emre Ergün. All rights reserved.
//

import ImageSlider
import UIKit

final class ImageSliderDemoViewController: UIViewController {
    
    let imageUrls = [
    "https://cdn.dolap.com/product/org/canta/kol-cantasi/herry_20425452.jpg",
    "https://cdn.dolap.com/product/org/canta/kol-cantasi/herry_20425453.jpg",
    "https://cdn.dolap.com/product/org/canta/kol-cantasi/herry_123070377.jpg"
    ]
    
    @IBOutlet private weak var imageSliderView: ImageSliderView!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Image Slider"
        
        prepareImageSlider()
    }
    
    private func prepareImageSlider() {
        let imageSliderPresenter = ImageSliderViewPresenter(imageUrls: imageUrls,
                                                            loopingEnabled: true,
                                                            view: imageSliderView)
        imageSliderView.presenter = imageSliderPresenter
    }
}
