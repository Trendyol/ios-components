//
//  UIImageViewExtensions.swift
//  ImageSlider
//
//  Created by Emre Ergün on 13.01.2020.
//  Copyright © 2020 Emre Ergün. All rights reserved.
//

import SDWebImage
import UIKit

public typealias ImageLoadingErrorCompletion = (_ image: UIImage?, _ error: Error?, _ url: URL?) -> Void

public extension UIImageView {
    func setImageWith(path: String?,
                            placeholder: UIImage? = nil,
                            completion: ImageLoadingErrorCompletion? = nil) {
        guard let unwrappedPath = path?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), let url = URL(string: unwrappedPath) else { return }
        self.sd_setImage(with: url, placeholderImage: placeholder) { (image, error, _, url) in
            completion?(image, error, url)
        }
    }
}
