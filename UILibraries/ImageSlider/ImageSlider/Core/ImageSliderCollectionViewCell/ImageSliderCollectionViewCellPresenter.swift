//
//  ImageSliderCollectionViewCellPresenter.swift
//  ProductDetail
//
//  Created by Emre Ergün on 8.11.2019.
//  Copyright © 2019 Trendyol.com. All rights reserved.
//

import Foundation

protocol ImageSliderCollectionViewCellPresenterInterface {
    var imageUrl: String { get set }

    func load()
}

final class ImageSliderCollectionViewCellPresenter {
    var imageUrl: String

    private weak var view: ImageSliderCollectionViewCellInterface?

    init(imageUrl: String, view: ImageSliderCollectionViewCellInterface?) {
        self.view = view
        self.imageUrl = imageUrl
    }
}

extension ImageSliderCollectionViewCellPresenter: ImageSliderCollectionViewCellPresenterInterface {
    func load() {
        view?.loadImage(url: imageUrl)
    }
}
