//
//  Request.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 3/22/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

public enum CacheFetchPolicy
{
    static let DefaultPolicy: CacheFetchPolicy = .CacheThenNetwork
    
    case CacheOnly
    case CacheThenNetwork
    case NetworkOnly
    case TryNetworkThenCache
}

public enum RetryPolicy
{
    static let DefaultPolicy: RetryPolicy = .SingleAttempt
    
    case SingleAttempt
    case MultipleAttempts(attemptCount: Int)
}

public struct Request<ModelType: MappableResponse>
{
    let method: VimeoClient.Method
    let path: String
    let parameters: VimeoClient.RequestParameters?
    
    let modelKeyPath: String?
    
    var cacheFetchPolicy: CacheFetchPolicy
    let shouldCacheResponse: Bool
    
    let retryPolicy: RetryPolicy
    
    // MARK: -
    
    init(method: VimeoClient.Method = .GET,
         path: String,
         parameters: VimeoClient.RequestParameters? = nil,
         modelKeyPath: String? = nil,
         cacheFetchPolicy: CacheFetchPolicy = .DefaultPolicy,
         shouldCacheResponse: Bool = true,
         retryPolicy: RetryPolicy = .DefaultPolicy)
    {
        self.method = method
        self.path = path
        self.parameters = parameters
        self.modelKeyPath = modelKeyPath
        self.cacheFetchPolicy = cacheFetchPolicy
        self.shouldCacheResponse = shouldCacheResponse
        self.retryPolicy = retryPolicy
    }
}