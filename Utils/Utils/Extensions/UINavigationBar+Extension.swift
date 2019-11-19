//
//  UINavigationBar+Extension.swift
//  Utils
//
//  Created by Emre Ergün on 19.11.2019.
//  Copyright © 2019 Trendyol.com. All rights reserved.
//

import UIKit

public extension UINavigationBar {
    func changeProperties(isTranslucent: Bool, backgroundImage: UIImage?, shadowColor: UIColor, backgroundColor: UIColor, barTintColor: UIColor) {
        self.barTintColor = barTintColor
        self.isTranslucent = isTranslucent
        
        if #available(iOS 13.0, *) {
            standardAppearance.shadowImage = shadowColor.as1ptImage()
            standardAppearance.backgroundImage = backgroundImage
            standardAppearance.backgroundColor = backgroundColor
            standardAppearance.backgroundEffect = .none
        } else {
            self.shadowImage = shadowColor.as1ptImage()
            setBackgroundImage(backgroundImage, for: UIBarMetrics.default)
            self.backgroundColor = backgroundColor
        }
    }
    
    func changeTransparency(to transparency: Transparency) {
        switch transparency {
        case .transparent:
            changeProperties(isTranslucent: false, backgroundImage: UIImage(), shadowColor: .clear, backgroundColor: .clear, barTintColor: .clear)
        case .opaque(let backgroundColor):
            changeProperties(isTranslucent: false, backgroundImage: UIColor.white.as1ptImage(), shadowColor: Color.borderColor, backgroundColor: backgroundColor, barTintColor: backgroundColor)
        }
    }
    
    enum Transparency {
        case transparent
        case opaque(backgroundColor: UIColor)
        
        public func isEqual(to state: Transparency) -> Bool {
            switch (self, state) {
            case (.transparent, .transparent):
                return true
            case (.opaque(_), .opaque(_)):
                return true
            default:
                return false
            }
        }
    }
}
