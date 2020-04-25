//
//  EnumDefaultValueSelectable.swift
//  PropertyWrapper
//
//  Created by aniltaskiran on 26.04.2020.
//  Copyright © 2020 Trendyol. All rights reserved.
//

public protocol EnumDefaultValueSelectable: Codable & CaseIterable & RawRepresentable where RawValue: Decodable, AllCases: BidirectionalCollection { }

public struct LastCase<T>: DefaultCodableInterface where T: EnumDefaultValueSelectable {
    public static var defaultValue: T { T.allCases.last! }
}

public struct FirstCase<T>: DefaultCodableInterface where T: EnumDefaultValueSelectable {
    public static var defaultValue: T { T.allCases.first! }
}

