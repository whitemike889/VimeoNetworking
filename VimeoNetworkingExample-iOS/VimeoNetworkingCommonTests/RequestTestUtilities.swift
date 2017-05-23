//
//  RequestTestUtilities.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Westendorf, Michael on 5/15/17.
//  Copyright © 2017 Vimeo. All rights reserved.
//

import Foundation
@testable import VimeoNetworking

class RequestComparisons
{
    static let CompareRetryPolicies = { (policyToTest: RetryPolicy, comparePolicy: RetryPolicy) -> Bool in
        switch policyToTest
        {
        case .singleAttempt:
            switch comparePolicy
            {
            case .singleAttempt:
                return true
            default:
                return false
            }
        default:
            if case .multipleAttempts(let attemptCount, let initialDelay) = policyToTest,
                case .multipleAttempts(let testValueCount, let testDelay) = comparePolicy
            {
                return attemptCount == testValueCount && initialDelay == testDelay
            }
            
            return false
        }
    }
    
    static func ValidateDefaults<ModelType>(request: Request<ModelType>) -> Bool
    {
        return request.method == .GET
            && request.parameters == nil
            && request.modelKeyPath == nil
            && request.shouldCacheResponse == true
            && request.cacheFetchPolicy == .networkOnly
            && RequestComparisons.CompareRetryPolicies(request.retryPolicy, .singleAttempt)
    }
}
