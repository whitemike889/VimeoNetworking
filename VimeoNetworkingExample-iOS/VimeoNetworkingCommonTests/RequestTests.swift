//
//  RequestTests.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Westendorf, Michael on 5/12/17.
//  Copyright © 2017 Vimeo. All rights reserved.
//

import XCTest
@testable import VimeoNetworking

class RequestTests: XCTestCase
{
    let retryPolicyTestClosure = { (policyToTest: RetryPolicy, comparePolicy: RetryPolicy) -> Bool in
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
    
    func test_CacheFetchPolicy_DefaultPolicyReturnsNetworkOnly()
    {
        XCTAssertTrue(CacheFetchPolicy.defaultPolicyForMethod(method: .GET) == .networkOnly, "defaultPolicyForMethod always returns .networkOnly")
        XCTAssertTrue(CacheFetchPolicy.defaultPolicyForMethod(method: .POST) == .networkOnly, "defaultPolicyForMethod always returns .networkOnly")
        XCTAssertTrue(CacheFetchPolicy.defaultPolicyForMethod(method: .PUT) == .networkOnly, "defaultPolicyForMethod always returns .networkOnly")
        XCTAssertTrue(CacheFetchPolicy.defaultPolicyForMethod(method: .PATCH) == .networkOnly, "defaultPolicyForMethod always returns .networkOnly")
        XCTAssertTrue(CacheFetchPolicy.defaultPolicyForMethod(method: .DELETE) == .networkOnly, "defaultPolicyForMethod always returns .networkOnly")
    }
    
    func test_RetryPolicy_DefaultPolicyForMethodShouldReturnSingleAttempt()
    {
        var defaultPolicy = RetryPolicy.defaultPolicyForMethod(for: .GET)
        XCTAssertTrue(RequestComparisons.CompareRetryPolicies(defaultPolicy, .singleAttempt), "RetryPolicy.defaultPolicyForMethod should return singleAttempt for all methods")
        
        defaultPolicy = RetryPolicy.defaultPolicyForMethod(for: .POST)
        XCTAssertTrue(RequestComparisons.CompareRetryPolicies(defaultPolicy, .singleAttempt), "RetryPolicy.defaultPolicyForMethod should return singleAttempt for all methods")

        defaultPolicy = RetryPolicy.defaultPolicyForMethod(for: .PUT)
        XCTAssertTrue(RequestComparisons.CompareRetryPolicies(defaultPolicy, .singleAttempt), "RetryPolicy.defaultPolicyForMethod should return singleAttempt for all methods")

        defaultPolicy = RetryPolicy.defaultPolicyForMethod(for: .PATCH)
        XCTAssertTrue(RequestComparisons.CompareRetryPolicies(defaultPolicy, .singleAttempt), "RetryPolicy.defaultPolicyForMethod should return singleAttempt for all methods")
        
        defaultPolicy = RetryPolicy.defaultPolicyForMethod(for: .DELETE)
        XCTAssertTrue(RequestComparisons.CompareRetryPolicies(defaultPolicy, .singleAttempt), "RetryPolicy.defaultPolicyForMethod should return singleAttempt for all methods")
    }
    
    func test_RetryPolicy_TryThreeTimesConstHasCorrectValues()
    {
        XCTAssertTrue(RequestComparisons.CompareRetryPolicies(RetryPolicy.TryThreeTimes, .multipleAttempts(attemptCount: 3, initialDelay: 2.0)), "TryThreeTimes const should be .multipleAttempts(3, 2.0), actually returned \(RetryPolicy.TryThreeTimes)")
    }
    
    func test_Request_DefaultValues()
    {
        let testPath = "/test/path"
        let request = Request<VIMNullResponse>(path: testPath)

        XCTAssertEqual(request.path, testPath)
        XCTAssertEqual(request.URI, testPath)

        XCTAssertTrue(RequestComparisons.ValidateDefaults(request: request))
    }
    
    func test_Request_setValuesThroughConstructor()
    {
        let testPath = "/test"
        let request = Request<VIMNullResponse>(method: .POST,
                                               path: testPath,
                                               parameters: ["param" : "test field"],
                                               modelKeyPath: "data",
                                               cacheFetchPolicy: .cacheOnly,
                                               shouldCacheResponse: true,
                                               retryPolicy: RetryPolicy.TryThreeTimes)
        
        XCTAssertEqual(request.path, testPath)
        XCTAssertEqual(request.URI, "/test?param=test%20field")
        XCTAssertTrue(request.shouldCacheResponse)
        XCTAssertEqual(request.method, .POST)
        XCTAssertEqual(request.cacheFetchPolicy, .cacheOnly)
        XCTAssertTrue(RequestComparisons.CompareRetryPolicies(request.retryPolicy, .multipleAttempts(attemptCount: 3, initialDelay: 2.0)))
    }
    
    func test_Request_AssociatedPageRequest()
    {
        let request = Request<VIMNullResponse>(path: "/test")
        let associatedRequest = request.associatedPageRequest(withNewPath: "/test?next_page=2")
        
        XCTAssertEqual(request.path, associatedRequest.path)
        XCTAssertEqual(request.method, associatedRequest.method)
        XCTAssertEqual(request.modelKeyPath, associatedRequest.modelKeyPath)
        XCTAssertEqual(request.shouldCacheResponse, associatedRequest.shouldCacheResponse)
        XCTAssertEqual(request.cacheFetchPolicy, associatedRequest.cacheFetchPolicy)
        XCTAssertTrue(RequestComparisons.CompareRetryPolicies(request.retryPolicy, associatedRequest.retryPolicy), "")
        
        let params = associatedRequest.parameters as! VimeoClient.RequestParametersDictionary
        XCTAssertEqual(params["next_page"] as! String, "2")
    }
}
