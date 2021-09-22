//
//  PaymentResponse.swift
//  PropertyWrapperTests
//
//  Created by Batuhan Saka on 22.09.2021.
//  Copyright © 2021 Trendyol. All rights reserved.
//

import PropertyWrapper

struct PaymentResponse: Decodable {
    let success: Bool
    @StringOrInt var orderId: String?
}
