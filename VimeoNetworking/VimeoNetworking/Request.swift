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
        /// Only request cached responses.  No network request is made.
    case CacheOnly
    
        /// Try to load from both cache and network, note that two results may be returned when using this method (cached, then network)
    case CacheThenNetwork
    
        /// Only try to load the request from network.  The cache is not queried
    case NetworkOnly
    
        /// First try the network request, then fallback to cache if it fails
    case TryNetworkThenCache
    
    /**
     Construct the default cache fetch policy for a given `Method`
     
     - parameter method: the request `Method`
     
     - returns: the default cache policy for the provided `Method`
     */
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

/// Describes how a request should handle retrying after failure
public enum RetryPolicy
{
        /// Only one attempt is made, no retry behavior
    case SingleAttempt
    
    /**
      Retry a request a specified number of times, starting with a specified delay
     
     - parameter attemptCount: maximum number of times this request should be retried
     - parameter initialDelay: the delay (in seconds) until first retry. The next delay is doubled with each retry to provide `back-off` behavior, which tends to lead to a greater probability of recovery
     */
    case MultipleAttempts(attemptCount: Int, initialDelay: NSTimeInterval)
    
    /**
     Construct the default retry policy for a given `Method`
     
     - parameter method: the request `Method`
     
     - returns: the default retry policy for the given `Method`
     */
    static func defaultPolicyForMethod(method: VimeoClient.Method) -> RetryPolicy
    {
        switch method
        {
        case .GET, .DELETE, .PATCH, .POST, .PUT:
            return .SingleAttempt
        }
    }
}

extension RetryPolicy
{
    /// Convenience `RetryPolicy` constructor that provides a standard multiple attempt policy
    static let TryThreeTimes: RetryPolicy = .MultipleAttempts(attemptCount: 3, initialDelay: 2.0)
}

/**
 *  Describes a single request.
 *
 *  `<ModelType>` is the type of the expected response model object
 */
public struct Request<ModelType: MappableResponse>
{
        /// HTTP method (e.g. `.GET`, `.POST`)
    public let method: VimeoClient.Method
    
        /// request url path (e.g. `/me`, `/videos/123456`)
    public let path: String
    
        /// any parameters to include with the request
    public let parameters: VimeoClient.RequestParameters?
    
        /// query a nested JSON key path for the response model object to be returned
    public let modelKeyPath: String?
    
        /// describes how this request should query for cached responses
    public var cacheFetchPolicy: CacheFetchPolicy
    
        /// whether a successful response to this request should be stored in cache
    public let shouldCacheResponse: Bool
    
        /// describes how the request should handle retrying after failure
    public var retryPolicy: RetryPolicy
    
    // MARK: -
    
    /**
     Build a new request, where the generic type `ModelType` is that of the expected response model object
     
     - parameter method:              the HTTP method (e.g. `.GET`, `.POST`), defaults to `.GET`
     - parameter path:                url path for this request
     - parameter parameters:          any optional parameters for this request, defaults to `nil`
     - parameter modelKeyPath:        optionally query a nested JSON key path for the response model object to be returned, defaults to `nil`
     - parameter cacheFetchPolicy:    describes how this request should query for cached responses, defaults to `.CacheThenNetwork`
     - parameter shouldCacheResponse: whether the response should be stored in cache, defaults to `true`
     - parameter retryPolicy:         describes how the request should handle retrying after failure, defaults to `.SingleAttempt`
     
     - returns: an initialized `Request`
     */
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