//
//  DefaultCodable.swift
//  PropertyWrapper
//
//  Created by aniltaskiran on 26.04.2020.
//  Copyright © 2020 Trendyol. All rights reserved.
//

public protocol DefaultCodableInterface {
    associatedtype RawValue: Codable
    
    static var defaultValue: RawValue { get }
}

@propertyWrapper
public struct DefaultCodable<T: DefaultCodableInterface>: Codable {
    public var wrappedValue: T.RawValue
    
    public init(wrappedValue: T.RawValue) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.wrappedValue = (try? container.decode(T.RawValue.self)) ?? T.defaultValue
    }
    
    public func encode(to encoder: Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
}

extension DefaultCodable: Equatable where T.RawValue: Equatable { }
extension DefaultCodable: Hashable where T.RawValue: Hashable { }

