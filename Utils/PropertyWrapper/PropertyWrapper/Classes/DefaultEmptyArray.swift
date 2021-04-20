//
//  DefaultEmptyArray.swift
//  PropertyWrapper
//
//  Created by Yusuf Özgül on 20.04.2021.
//  Copyright © 2021 Trendyol. All rights reserved.
//

public struct DefaultEmptyArray<T: Codable>: DefaultCodableInterface {
    public static var defaultValue: [T] { return [] }
}
