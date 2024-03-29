//
//  KeyedDecodingContainer.swift
//  PropertyWrapper
//
//  Created by aniltaskiran on 26.04.2020.
//  Copyright © 2020 Trendyol. All rights reserved.
//

public extension KeyedDecodingContainer {
    func decode<T>(_: DefaultCodable<T>.Type, forKey key: Key) throws -> DefaultCodable<T> {
        if let value = try decodeIfPresent(DefaultCodable<T>.self, forKey: key) {
            return value
        } else {
            return DefaultCodable(wrappedValue: T.defaultValue)
        }
    }

    func decode<T: ExpressibleByNilLiteral>(_ type: StringOrInt<T>.Type, forKey key: K) throws -> StringOrInt<T> {
        if let value = try decodeIfPresent(type, forKey: key) {
            return value
        }
        return StringOrInt(wrappedValue: nil)
    }
}
