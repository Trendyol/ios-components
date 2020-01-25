//
//  UIColor+Extension.swift
//  Utils
//
//  Created by Ahmet Keskin on 5.11.2019.
//  Copyright © 2019 Trendyol.com. All rights reserved.
//

import UIKit

public extension UIColor {
    var hexString: String? {
        guard let components = self.cgColor.components, components.count == 3 else {
            return nil
        }

        let red = components[0]
        let green = components[1]
        let blue = components[2]
        
        return String(format: "%02X%02X%02X", (Int)(red * 255), (Int)(green * 255), (Int)(blue * 255))
    }

    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        defer { UIGraphicsEndImageContext() }
        
        let ctx = UIGraphicsGetCurrentContext()
        self.setFill()
        ctx!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image!
    }

    static func getHexColor(_ hex: Int, alpha: CGFloat = 1.0) -> UIColor {
        let red = CGFloat((hex & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00ff00) >>  8) / 255.0
        let blue = CGFloat((hex & 0x0000ff) >>  0) / 255.0

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
