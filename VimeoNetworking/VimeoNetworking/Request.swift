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
    case CacheOnly
    case CacheThenNetwork
    case NetworkOnly
    case TryNetworkThenCache
    
    static func defaultPolicyForMethod(method: VimeoClient.Method) -> CacheFetchPolicy
    {
        switch method
        {
        case .GET:
            return .CacheThenNetwork
        case .DELETE, .PATCH, .POST, .PUT:
            return .NetworkOnly
        }
    }
}

public enum RetryPolicy
{
    case SingleAttempt
    case MultipleAttempts(attemptCount: Int)
    
    static func defaultPolicyForMethod(method: VimeoClient.Method) -> RetryPolicy
    {
        switch method
        {
        case .GET, .DELETE, .PATCH, .POST, .PUT:
            return .SingleAttempt
        }
    }
}

public struct Request<ModelType: MappableResponse>
{
    public let method: VimeoClient.Method
    public let path: String
    public let parameters: VimeoClient.RequestParameters?
    
    public let modelKeyPath: String?
    
    public var cacheFetchPolicy: CacheFetchPolicy
    public let shouldCacheResponse: Bool
    
    public let retryPolicy: RetryPolicy
    
    // MARK: -
    
    public init(method: VimeoClient.Method = .GET,
         path: String,
         parameters: VimeoClient.RequestParameters? = nil,
         modelKeyPath: String? = nil,
         cacheFetchPolicy: CacheFetchPolicy? = nil,
         shouldCacheResponse: Bool? = nil,
         retryPolicy: RetryPolicy? = nil)
    {
        self.method = method
        self.path = path
        self.parameters = parameters
        self.modelKeyPath = modelKeyPath
        self.cacheFetchPolicy = cacheFetchPolicy ?? CacheFetchPolicy.defaultPolicyForMethod(method)
        self.shouldCacheResponse = shouldCacheResponse ?? (method == .GET)
        self.retryPolicy = retryPolicy ?? RetryPolicy.defaultPolicyForMethod(method)
    }
}