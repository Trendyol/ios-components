//
//  PriceSetter.swift
//  Utils
//
//  Created by Ahmet Keskin on 11.11.2019.
//  Copyright © 2019 Trendyol.com. All rights reserved.
//

public class PriceSetter {
    private static func doesHaveFraction(price: Double) -> Bool {
        return price != floor(price)
    }

    static func shouldHideMarketPrice(salePrice: Double?, marketPrice: Double?) -> Bool {
        guard let salePrice = salePrice, let marketPrice = marketPrice else { return true }
        return marketPrice <= salePrice
    }

    static func shouldHideMarketPrice(salePrice: Double, marketPrice: Double) -> Bool {
        return marketPrice <= salePrice
    }

    public static func setPriceWithoutFraction(_ price: Double) -> String {
        if doesHaveFraction(price: price) {
            return String(format: "%.2f TL", price)
        }
        return String(format: "%.0f TL", price)
    }

    public static func setPrice(_ price: Double, isNegative: Bool = false) -> String {
        let dash = isNegative && price > 0 ? "-" : ""
        if Int(price).digits.count < 4 {
            return dash + String(format: "%.2f TL", price)
        }
        return dash + String(format: "%d TL", Int(price))
    }
}

extension BinaryInteger {
    var digits: [Int] {
        return String(describing: self).compactMap { Int(String($0)) }
    }
}
