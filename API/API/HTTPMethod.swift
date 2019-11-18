//
//  HTTPMethod.swift
//  API
//
//  Created by Ahmet Keskin on 31.10.2019.
//  Copyright © 2019 Trendyol.com. All rights reserved.
//

import Foundation
import Alamofire

public typealias HTTPMethod = Alamofire.HTTPMethod
public typealias HTTPHeaders = Alamofire.HTTPHeaders
public typealias HTTPHeader = Alamofire.HTTPHeader

public extension HTTPMethod {
    var encoding: ParameterEncoding {
        switch self {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
}
