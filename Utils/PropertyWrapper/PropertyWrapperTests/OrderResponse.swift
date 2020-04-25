//
//  Entity.swift
//  PropertyWrapperTests
//
//  Created by aniltaskiran on 26.04.2020.
//  Copyright © 2020 Trendyol. All rights reserved.
//
@testable import PropertyWrapper

struct OrderResponse: Codable {
    @DefaultCodable<FirstCase> var status: OrderStatus
}

enum OrderStatus: String, EnumDefaultValueSelectable {
    case new, inProgress, shipped, canceled
}
