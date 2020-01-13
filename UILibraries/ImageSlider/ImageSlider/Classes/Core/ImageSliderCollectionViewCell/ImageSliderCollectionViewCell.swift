//
//  ImageSliderCollectionViewCell.swift
//  ProductDetail
//
//  Created by Emre Ergün on 8.11.2019.
//  Copyright © 2019 Trendyol.com. All rights reserved.
//

import UIKit

protocol ImageSliderCollectionViewCellInterface: class {
    func loadImage(url: String?)
    func resetImage()
}

final class ImageSliderCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.contentMode = .scaleAspectFill
        }
    }
    
    var presenter: ImageSliderCollectionViewCellPresenterInterface! {
        didSet {
            presenter.load()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetImage()
    }
}

extension ImageSliderCollectionViewCell: ImageSliderCollectionViewCellInterface {
    func resetImage() {
        imageView.image = nil
    }
    
    func loadImage(url: String?) {
        imageView.setImageWith(path: url)
    }
}
