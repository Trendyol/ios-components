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
    
    let imageCache = NSCache<NSString, UIImage>()
    
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
        guard let url = url, let imageURL = URL(string: url) else { return }
        if let imageFromCache = imageCache.object(forKey: NSString(string: url)) {
            imageView.image = imageFromCache
            print("CACHE used! \(url)")
        } else {
            print("CACHE not used \(url)")
            DispatchQueue.global().async { [weak self] in
                guard let imageData = try? Data(contentsOf: imageURL) else { return }
                guard let image = UIImage(data: imageData) else { return }
                self?.imageCache.setObject(image, forKey: NSString(string: url))
                print("CACHE saved: \(url)")
                DispatchQueue.main.async { [weak self] in
                    self?.imageView.image = image
                }
            }
        }
    }
}
