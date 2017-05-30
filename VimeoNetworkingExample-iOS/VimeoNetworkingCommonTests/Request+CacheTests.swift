//
//  Request+CacheTests.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Westendorf, Michael on 5/25/17.
//  Copyright © 2017 Vimeo. All rights reserved.
//

import XCTest
@testable import VimeoNetworking

class Request_CacheTests: XCTestCase
{
    func test_RequestCache_cacheKeyReturnsCorrectValue()
    {
        let request = Request<VIMNullResponse>(path: "/test/path")
        let testCacheKey = "cached.test.path." + String(request.path.hashValue)
        
        XCTAssertEqual(request.cacheKey, testCacheKey)
    }
}
