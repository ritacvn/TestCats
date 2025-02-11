//
//  URLSessionProtocol.swift
//  CatsTest
//
//  Created by Rita Vasconcelos on 11/02/25.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
            let task: URLSessionDataTask = dataTask(with: request, completionHandler: completionHandler)
            return task
        }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
