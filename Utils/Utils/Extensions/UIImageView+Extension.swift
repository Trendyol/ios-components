//
//  UIImageView+Extension.swift
//  Utils
//
//  Created by Ahmet Keskin on 5.11.2019.
//  Copyright © 2019 Trendyol.com. All rights reserved.
//

import UIKit
import SDWebImage

public typealias ImageLoadingErrorCompletion = (_ image: UIImage?, _ error: Error?, _ url: URL?) -> Void

public extension UIImageView {

    /// Asynchronously downloads an image from the specified URL, and sets it once the request is finished. Any previous image request for the receiver will be cancelled.
    /// If the image is cached locally, the image is set immediately, otherwise the specified placeholder image will be set immediately, and then the remote image will be set once the request is finished.
    ///
    /// - Parameters:
    ///   - path: The string path for the image.
    ///   - placeholder: The image to be set initially, until the image request finishes. Default value is `nil`
    ///   - completion: A block called when operation has been completed. This block has no return value and takes the requested UIImage as first parameter. In case of error the image parameter is nil and the second parameter may contain an NSError. The third parameter is the original image url. Default value is `nil`
    func setImageWith(path: String?,
                            placeholder: UIImage? = nil,
                            completion: ImageLoadingErrorCompletion? = nil) {
        guard let unwrappedPath = path?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), let url = URL(string: unwrappedPath) else { return }
        self.sd_setImage(with: url, placeholderImage: placeholder) { (image, error, _, url) in
            completion?(image, error, url)
        }
    }
}
