//
//  Optional+Extension.swift
//  Utils
//
//  Created by Ahmet Keskin on 5.11.2019.
//  Copyright © 2019 Trendyol.com. All rights reserved.
//

public extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        switch self {
        case let string?:
            return string.isEmpty
        case nil:
            return true
        }
    }

    var isNotNilOrEmpty: Bool {
        switch self {
        case let string?:
            return !string.isEmpty
        case nil:
            return false
        }
    }

}

public extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        switch self {
        case let collection?:
            return collection.isEmpty
        case nil:
            return true
        }
    }

    var isNotNilOrEmpty: Bool {
        switch self {
        case let collection?:
            return !collection.isEmpty
        case nil:
            return false
        }
    }
}
