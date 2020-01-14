//
//  ImageSliderCollectionViewCell.swift
//  ProductDetail
//
//  Created by Emre Ergün on 8.11.2019.
//  Copyright © 2019 Trendyol.com. All rights reserved.
//

import TYPinchableImageView
import UIKit

protocol ImageSliderCollectionViewCellInterface: class {
    func loadImage(url: String?)
    func resetImage()
}

final class ImageSliderCollectionViewCell: UICollectionViewCell {
    lazy var contentImageView: PinchableImageView = {
        let imageView = PinchableImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    @IBOutlet private weak var someImageView: UIImageView!
    
    var presenter: ImageSliderCollectionViewCellPresenterInterface! {
        didSet {
            presenter.load()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        contentImageView.embedEdgeToEdge(in: self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetImage()
    }
}

extension ImageSliderCollectionViewCell: ImageSliderCollectionViewCellInterface {
    func resetImage() {
        contentImageView.image = nil
    }
    
    func loadImage(url: String?) {
        contentImageView.setImageWith(path: url)
    }
}
