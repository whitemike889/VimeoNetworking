//
//  Request.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 3/22/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

struct Request<ModelType where ModelType: Mappable>
{
    init(method: VimeoClient.Method = .GET,
         path: String,
         parameters: VimeoClient.RequestParameters? = nil,
         modelKeyPath: String? = nil,
         cacheFetchPolicy: CacheFetchPolicy = .LocalThenNetwork,
         shouldCacheResponse: Bool = true,
         retryPolicy: RetryPolicy = .SingleAttempt)
    {
        self.method = method
        self.path = path
        self.parameters = parameters
        self.modelKeyPath = modelKeyPath
        self.cacheFetchPolicy = cacheFetchPolicy
        self.shouldCacheResponse = shouldCacheResponse
        self.retryPolicy = retryPolicy
    }
    
    let method: VimeoClient.Method
    let path: String
    let parameters: VimeoClient.RequestParameters?
    
    let modelKeyPath: String?
    
    let cacheFetchPolicy: CacheFetchPolicy
    let shouldCacheResponse: Bool
    
    let retryPolicy: RetryPolicy
}

// TODO: Should we move these out of this file? [RH] (3/29/16)

enum CacheFetchPolicy
{
    case LocalOnly
    case LocalThenNetwork
    case NetworkOnly
}

enum RetryPolicy
{
    case SingleAttempt
    case MultipleAttempts(attemptCount: Int)
}