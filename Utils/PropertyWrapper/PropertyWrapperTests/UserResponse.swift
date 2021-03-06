//
//  UserResponse.swift
//  PropertyWrapperTests
//
//  Created by aniltaskiran on 26.04.2020.
//  Copyright © 2020 Trendyol. All rights reserved.
//
@testable import PropertyWrapper

enum UserType: String, EnumDefaultValueSelectable {
    case admin, user, none
}

struct UserResponse: Codable {
    @DefaultCodable<LastCase> var user: UserType
    @DefaultCodable<DefaultFalse> var isAdmin: Bool
    @DefaultCodable<DefaultEmptyArray> var tags: [String]
}
