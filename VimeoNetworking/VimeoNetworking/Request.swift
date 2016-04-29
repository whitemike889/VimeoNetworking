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
    static let TryThreeTimes: RetryPolicy = .MultipleAttempts(attemptCount: 3, initialDelay: 2.0)
    
    case SingleAttempt
    case MultipleAttempts(attemptCount: Int, initialDelay: NSTimeInterval)
}

public struct Request<ModelType: MappableResponse>
{
    public let method: VimeoClient.Method
    public let path: String
    public let parameters: VimeoClient.RequestParameters?
    
    public let modelKeyPath: String?
    
    public var cacheFetchPolicy: CacheFetchPolicy
    public let shouldCacheResponse: Bool
    
    public var retryPolicy: RetryPolicy
    
    // MARK: -
    
    public init(method: VimeoClient.Method = .GET,
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