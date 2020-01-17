//
//  UIImageViewExtensions.swift
//  ImageSlider
//
//  Created by Emre Ergün on 13.01.2020.
//  Copyright © 2020 Emre Ergün. All rights reserved.
//

import SDWebImage
import UIKit

public typealias ImageLoadingCompletion = (Result<UIImage, ImageLoadingError>) -> Void

public enum ImageLoadingError: Error {
    case internalError(Error)
    case noImage
}

public extension UIImageView {
    func setImageWith(path: String?,
                            placeholder: UIImage? = nil,
                            completion: ImageLoadingCompletion? = nil) {
        guard let unwrappedPath = path?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), let url = URL(string: unwrappedPath) else { return }
        self.sd_setImage(with: url, placeholderImage: placeholder) { (image, error, _, _) in
            if let error = error {
                completion?(.failure(ImageLoadingError.internalError(error)))
                return
            }
            
            guard let image = image else {
                completion?(.failure(ImageLoadingError.noImage))
                return
            }
            
            completion?(.success(image))
        }
    }
}
