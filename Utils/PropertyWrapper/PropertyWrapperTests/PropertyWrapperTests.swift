//
//  PropertyWrapperTests.swift
//  PropertyWrapperTests
//
//  Created by aniltaskiran on 26.04.2020.
//  Copyright © 2020 Trendyol. All rights reserved.
//

import XCTest
@testable import PropertyWrapper

// swiftlint:disable force_try
// swiftlint:disable force_unwrapping
final class PropertyWrapperTests: XCTestCase {
    func test_AdminType_ShouldBeGivenTypeSelected() {
        let jsonData = #"{ "user": "admin" }"#.data(using: .utf8)!
        let response = try! JSONDecoder().decode(UserResponse.self, from: jsonData)
        XCTAssertEqual(response.user, UserType.admin)
    }

    func test_FailableUserType_ShouldBeLastCaseSelected() {
        let jsonData = #"{ "user": "NewTypeUser" }"#.data(using: .utf8)!
        let response = try! JSONDecoder().decode(UserResponse.self, from: jsonData)
        XCTAssertEqual(response.user, UserType.none)
    }

    func test_NewStatusAdded_ShouldBeFirstCaseSelected() {
        let jsonData = #"{ "status": "newStatusAdded" }"#.data(using: .utf8)!
        let response = try! JSONDecoder().decode(OrderResponse.self, from: jsonData)
        XCTAssertEqual(response.status, OrderStatus.new)
    }

    func test_EmptyFieldOnOrderResponse_ShouldShowOrderStatusShouldBeTrue() {
        let jsonData = #"{ }"#.data(using: .utf8)!
        let response = try! JSONDecoder().decode(OrderResponse.self, from: jsonData)
        XCTAssertTrue(response.shouldShowOrderStatus)
    }

    func test_EmptyFieldOnUserResponse_IsAdminShouldBeFalse() {
        let jsonData = #"{ }"#.data(using: .utf8)!
        let response = try! JSONDecoder().decode(UserResponse.self, from: jsonData)
        XCTAssertFalse(response.isAdmin)
    }
}
// swiftlint:enable force_try
// swiftlint:enable force_unwrapping
