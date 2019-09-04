//
//  Session.swift
//  VimeoNetworking
//
//  Created by Rogerio de Paula Assis on 8/31/19.
//  Copyright © 2019 Vimeo. All rights reserved.
//

import Foundation

protocol Cancellable {
    func cancel()
}

extension URLSessionTask: Cancellable {}

class Session {
    
    /// The default Session used by the free functions inside the VimeoNetworking module
    static let `default` = Session()
    
    private let urlSession: URLSession
    
    init(
        configuration: URLSessionConfiguration = .default,
        delegate: SessionDelegate = SessionDelegate(),
        delegateCallbackQueue: OperationQueue? = nil
    ) {
        self.urlSession = URLSession(
            configuration: configuration,
            delegate: delegate,
            delegateQueue: delegateCallbackQueue
        )
    }
    
    func request(
        _ convertible: URLRequestConvertible,
        then callback: @escaping (Result<Data, VimeoNetworkingError>) -> Void
    ) -> Cancellable? {
        return nil
    }
    
    func requestJSON(
        _ convertible: URLRequestConvertible,
        then callback: @escaping (Result<Any, VimeoNetworkingError>) -> Void
    ) -> Cancellable? {
        return nil
    }
    
    func request<T: Decodable>(
        _ convertible: URLRequestConvertible,
        then callback: @escaping (Result<T, VimeoNetworkingError>) -> Void) -> Cancellable? {
        return nil
    }
}
