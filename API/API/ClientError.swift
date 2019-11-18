//
//  ClientError.swift
//  API
//
//  Created by Ahmet Keskin on 6.11.2019.
//  Copyright © 2019 Trendyol.com. All rights reserved.
//

import Foundation

public protocol APIError: Codable {
    var message: String { get }
    var code: Int { get }
}

public class ClientError: APIError {
    let errorDetails: [ClientErrorItem]
    
    public var message: String {
        return errorDetails.first?.errorMessage ?? ""
    }
    
    public var code: Int {
        return Int(errorDetails.first?.errorCode ?? "") ?? 400
    }
}

class ClientErrorItem: Codable {
    let errorCode: String
    let errorMessage: String
}

public enum APIClientError: Error {
    case handledError(error: APIError)
    case networkError
    case decoding
    case timeout
    
    public var message: String {
        switch self {
        case .handledError(let error):
            return error.message
        case .decoding:
            return "Decoding error"
        case .networkError:
            return "Network error"
        case .timeout:
            return "Timeout"
        }
    }
}
