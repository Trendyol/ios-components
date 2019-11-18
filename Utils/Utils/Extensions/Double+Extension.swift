//
//  Double+Extension.swift
//  Utils
//
//  Created by Ahmet Keskin on 5.11.2019.
//  Copyright © 2019 Trendyol.com. All rights reserved.
//

public extension Double {
    var stringValue: String {
        return String(self)
    }

    func truncate(places: Int) -> Double {
        let result = Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
        return result
    }
}
