//
//  Request+CategoryTests.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Westendorf, Michael on 5/15/17.
//  Copyright © 2017 Vimeo. All rights reserved.
//

import XCTest
@testable import VimeoNetworking

class Request_CategoryTests: XCTestCase
{
    func test_Request_ValidateCategoriesRequest()
    {
        let request = CategoryRequest.getCategoriesRequest()
        
        XCTAssertEqual(request.URI, "/categories")
        XCTAssertTrue(RequestComparisons.ValidateDefaults(request: request))
    }
    
    func test_Request_ValidateCateogryRequest()
    {
        let request = CategoryRequest.getCategoryRequest(forCategoryURI: "/animation")
        
        XCTAssertEqual(request.URI, "/animation")
        XCTAssertTrue(RequestComparisons.ValidateDefaults(request: request))
    }
}
