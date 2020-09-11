//
//  UserDefaults.swift
//  PropertyWrapper
//
//  Created by aniltaskiran on 26.04.2020.
//  Copyright © 2020 Trendyol. All rights reserved.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    var key: String
    var initialValue: T
    var wrappedValue: T {
        set { UserDefaults.standard.set(newValue, forKey: key) }
        get { UserDefaults.standard.object(forKey: key) as? T ?? initialValue }
    }
}
