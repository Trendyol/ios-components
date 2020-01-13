//
//  ViewController.swift
//  ImageSliderDemoApp
//
//  Created by Emre Ergün on 13.01.2020.
//  Copyright © 2020 Emre Ergün. All rights reserved.
//

import ImageSlider
import UIKit

final class ViewController: UIViewController {

    @IBOutlet private weak var imageSlider: ImageSliderView!
    
    let sampleImageUrls = [
    "https://cdn.dolap.com/product/org/canta/kol-cantasi/herry_20425452.jpg",
    "https://cdn.dolap.com/product/org/canta/kol-cantasi/herry_20425453.jpg",
    "https://cdn.dolap.com/product/org/canta/kol-cantasi/herry_20425454.jpg",
    "https://cdn.dolap.com/product/org/canta/kol-cantasi/herry_123070377.jpg",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareImageSlider()
    }
    
    private func prepareImageSlider() {
        let imageSliderPresenter = ImageSliderViewPresenter(imageUrls: sampleImageUrls, view: imageSlider)
        imageSlider.presenter = imageSliderPresenter
    }
}

