//
//  URLSessionMock.swift
//  CatsTestTests
//
//  Created by Rita Vasconcelos on 11/02/25.
//

import Foundation

class URLSessionMock: URLSessionProtocol {
    var mockData: Data?
    var mockError: Error?
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        completionHandler(mockData, nil, mockError)
        return URLSessionDataTaskMock()
    }
}

class URLSessionDataTaskMock: URLSessionDataTaskProtocol {
    func resume() {}
}
