//
//  Request.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 3/22/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

/// Describes how a request should query the cache
public enum CacheFetchPolicy
{
    static let DefaultPolicy: CacheFetchPolicy = .CacheThenNetwork
    
    case CacheOnly
    case CacheThenNetwork
    case NetworkOnly
    case TryNetworkThenCache
}

/// Describes how a request should handle retrying after failure
public enum RetryPolicy
{
    static let DefaultPolicy: RetryPolicy = .SingleAttempt
    static let TryThreeTimes: RetryPolicy = .MultipleAttempts(attemptCount: 3, initialDelay: 2.0)
    
    case SingleAttempt
    case MultipleAttempts(attemptCount: Int, initialDelay: NSTimeInterval)
}

/**
 *  Describes a single request.
 *
 *  `<ModelType>` is the type of the expected response model object
 */
public struct Request<ModelType: MappableResponse>
{
        /// <#Description#>
    public let method: VimeoClient.Method
    
        /// <#Description#>
    public let path: String
    
        /// <#Description#>
    public let parameters: VimeoClient.RequestParameters?
    
        /// <#Description#>
    public let modelKeyPath: String?
    
        /// <#Description#>
    public var cacheFetchPolicy: CacheFetchPolicy
    
        /// <#Description#>
    public let shouldCacheResponse: Bool
    
        /// <#Description#>
    public var retryPolicy: RetryPolicy
    
    // MARK: -
    
    /**
     Build a new request, where the generic type `ModelType` is that of the expected response model object
     
     - parameter method:              the HTTP method (e.g. `.GET`, `.POST`), defaults to `.GET`
     - parameter path:                url path for this request
     - parameter parameters:          any optional parameters for this request, defaults to `nil`
     - parameter modelKeyPath:        optionally query a nested key path for the response model object, defaults to `nil`
     - parameter cacheFetchPolicy:    how the request should query the cache, defaults to `.CacheThenNetwork`
     - parameter shouldCacheResponse: whether the response should be stored in cache, defaults to `true`
     - parameter retryPolicy:         how the request should handle retrying after failure, defaults to `.SingleAttempt`
     
     - returns: an initialized `Request`
     */
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