//
//  Color.swift
//  Utils
//
//  Created by Ahmet Keskin on 7.11.2019.
//  Copyright © 2019 Trendyol.com. All rights reserved.
//

import UIKit

public struct Color {
    public static var primaryText: UIColor {
        return UIColor.getHexColor(0x333333) // 51|51|51
    }
    
    public static var secondaryText: UIColor {
        return UIColor.getHexColor(0x666666) //102|102|102
    }
    
    public static var background: UIColor {
        return UIColor.getHexColor(0xf5f5f5) //245|245|245
    }
    
    public static var primaryGreenText: UIColor {
        return UIColor.getHexColor(0x10bf8b) //16|191|139
    }
    
    public static var primaryGreenButton: UIColor {
        return UIColor.getHexColor(0x25d6a2) //37|214|162
    }
    
    public static var borderColor: UIColor {
        return UIColor.getHexColor(0xe6e6e6) //230|230|230
    }
}
