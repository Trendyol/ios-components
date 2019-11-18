//
//  Endpoint.swift
//  API
//
//  Created by Ahmet Keskin on 31.10.2019.
//  Copyright © 2019 Trendyol.com. All rights reserved.
//

import Foundation

public protocol Endpoint {
    var baseUrl: String { get }
    var path: String { get }
    var params: [String: Any]? { get }
    var headers: HTTPHeaders? { get }
    var url: URL { get }
    var method: HTTPMethod { get }
}

public extension Endpoint {
    var params: [String: Any]? {
        return nil
    }
    
    var url: URL {
        return URL(string: baseUrl + path)!
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
