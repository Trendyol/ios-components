//
//  PropertyWrapperTests.swift
//  PropertyWrapperTests
//
//  Created by aniltaskiran on 26.04.2020.
//  Copyright © 2020 Trendyol. All rights reserved.
//

import XCTest
@testable import PropertyWrapper

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

    func test_EmptyArrayUserResponse_TagsShouldBeEmpty() {
        let jsonData = #"{ "tags": null }"#.data(using: .utf8)!
        let response = try! JSONDecoder().decode(UserResponse.self, from: jsonData)
        XCTAssertEqual(response.tags, [])
    }

    func test_EmptyArrayUserResponse_TagsShouldNotBeEmpty() {
        let jsonData = #"{ "tags": ["iOS", "mobile"] }"#.data(using: .utf8)!
        let response = try! JSONDecoder().decode(UserResponse.self, from: jsonData)
        XCTAssertEqual(response.tags, ["iOS", "mobile"])
    }

    func test_PaymentResponseWithIntegerOrderId_OrderIdShouldBeDecodedAsString() {
        let jsonData = #"{ "success": true, "orderId": 123 }"#.data(using: .utf8)!
        let response = try! JSONDecoder().decode(PaymentResponse.self, from: jsonData)
        XCTAssertEqual(response.orderId, "123")
    }

    func test_PaymentResponseWithStringOrderId_OrderIdShouldBeDecodedAsString() {
        let jsonData = #"{ "success": true, "orderId": "123" }"#.data(using: .utf8)!
        let response = try! JSONDecoder().decode(PaymentResponse.self, from: jsonData)
        XCTAssertEqual(response.orderId, "123")
    }

    func test_PaymentResponseWithNilOrderId_OrderIdShouldBeDecodedAsNil() {
        let jsonData = #"{ "success": true, "orderId": null }"#.data(using: .utf8)!
        let response = try! JSONDecoder().decode(PaymentResponse.self, from: jsonData)
        XCTAssertNil(response.orderId)
    }

    func test_PaymentResponseWithoutOrderId_OrderIdShouldBeDecodedAsNil() {
        let jsonData = #"{ "success": true }"#.data(using: .utf8)!
        let response = try! JSONDecoder().decode(PaymentResponse.self, from: jsonData)
        XCTAssertNil(response.orderId)
    }
}
