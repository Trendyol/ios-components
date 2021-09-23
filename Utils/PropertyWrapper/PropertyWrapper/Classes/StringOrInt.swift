//
//  StringOrInt.swift
//  PropertyWrapper
//
//  Created by Batuhan Saka on 22.09.2021.
//  Copyright © 2021 Trendyol. All rights reserved.
//

import Foundation

public protocol ExpressibleByString {
    init(from stringValue: String)
}

extension String: ExpressibleByString {
    public init(from stringValue: String) { self = stringValue }
}

extension Optional: ExpressibleByString where Wrapped == String {
    public init(from stringValue: String) { self = stringValue }
}

@propertyWrapper
public struct StringOrInt<T: ExpressibleByString>: Decodable {
    public var wrappedValue: T

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let integerValue = try? container.decode(Int.self) {
            wrappedValue = .init(from: String(integerValue))
        } else {
            wrappedValue = try .init(from: container.decode(String.self))
        }
    }
}
