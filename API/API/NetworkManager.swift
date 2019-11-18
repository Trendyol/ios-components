//
//  NetworkManager.swift
//  API
//
//  Created by Ahmet Keskin on 31.10.2019.
//  Copyright © 2019 Trendyol.com. All rights reserved.
//

import Foundation
import Alamofire

public typealias Completion<T> = (Result<T, APIClientError>) -> Void where T: Decodable

public protocol NetworkProtocol {
    associatedtype EndpointItem: Endpoint
    
    func request<T: Decodable>(endpoint: EndpointItem, type: T.Type, completion: @escaping Completion<T>)
}

final public class NetworkManager<EndpointItem: Endpoint>: NetworkProtocol {
    lazy var sessionManager: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        return Alamofire.Session(configuration: configuration)
    }()
    
    public init() {}
    
    public func request<T: Decodable>(endpoint: EndpointItem, type: T.Type, completion: @escaping Completion<T>) {
        sessionManager.request(endpoint.url,
                               method: endpoint.method,
                               parameters: endpoint.params,
                               encoding: endpoint.method.encoding,
                               headers: endpoint.headers)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let data):
                    guard !data.isEmpty else {
                        completion(.success(Empty.value as! T))
                        return
                    }
                    do {
                        let decodedObject = try JSONDecoder().decode(type, from: data)
                        completion(.success(decodedObject))
                    } catch {
                        completion(.failure(.decoding))
                    }
                    
                case .failure(let error):
                    if (error as NSError).code == NSURLErrorTimedOut {
                        completion(.failure(.timeout))
                    } else {
                        do {
                            guard let data = response.data else {
                                completion(.failure(.networkError))
                                return
                            }
                            let clientError = try JSONDecoder().decode(ClientError.self, from: data)
                            completion(.failure(.handledError(error: clientError)))
                        } catch {
                            completion(.failure(.decoding))
                        }
                    }
                }
        }
    }
}
