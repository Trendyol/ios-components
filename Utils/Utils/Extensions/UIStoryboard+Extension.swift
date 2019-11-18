//
//  UIStoryboard+Extension.swift
//  Utils
//
//  Created by Ahmet Keskin on 5.11.2019.
//  Copyright © 2019 Trendyol.com. All rights reserved.
//

import UIKit

public extension UIStoryboard {
    // Instantinate view from storyboard directly
    func instantiateViewController<T: ViewInterface>(viewClass: T.Type) -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardId) as? T else { fatalError() }
        return viewController
    }

    // Instantinate view embed in navigation controller
    func instantiateViewControllerAsFirstViewControllerOfNavigationController<T: ViewInterface>(viewClass: T.Type) -> T {
        guard let navigationController = self.instantiateViewController(withIdentifier: T.storyboardId) as? UINavigationController, let viewController = navigationController.viewControllers.first as? T else { fatalError() }
        return viewController
    }
}

