//
//  VimeoNetworking.swift
//  VimeoNetworking
//
//  Created by Rogerio de Paula Assis on 8/31/19.
//  Copyright © 2019 Vimeo. All rights reserved.
//

import Foundation

func request(
    _ request: URLRequestConvertible,
    then callback: @escaping ((Result<Data, VimeoNetworkingError>) -> Void)
) -> Cancellable? {
    return Session.default.request(request, then: callback)
}

func requestJSON(
    _ convertible: URLRequestConvertible,
    then callback: @escaping (Result<Any, VimeoNetworkingError>) -> Void
) -> Cancellable? {
    return Session.default.requestJSON(convertible, then: callback)
}

func request<T: Decodable>(
    _ convertible: URLRequestConvertible,
    then callback: @escaping (Result<T, VimeoNetworkingError>) -> Void) -> Cancellable? {
    return Session.default.request(convertible, then: callback)
}
