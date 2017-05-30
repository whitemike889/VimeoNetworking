//
//  Request+ConfigsTest.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Westendorf, Michael on 5/25/17.
//  Copyright © 2017 Vimeo. All rights reserved.
//

import XCTest
@testable import VimeoNetworking

class Request_ConfigsTest: XCTestCase
{
    func test_RequestConfigs_ValidateConfigsRequestFromCache()
    {
        let request = Request<VIMNullResponse>.configsRequest(fromCache: true)
        
        XCTAssertEqual(request.URI, "/configs")
        XCTAssertEqual(request.method, .GET)
        XCTAssertEqual(request.cacheFetchPolicy, .cacheOnly)
    }
    
    func test_RequestConfigs_ValidateConfigsRequestFromNetwork()
    {
        let request = Request<VIMNullResponse>.configsRequest(fromCache: false)
        
        XCTAssertEqual(request.URI, "/configs")
        XCTAssertEqual(request.method, .GET)
        XCTAssertEqual(request.cacheFetchPolicy, .networkOnly)
    }
}
