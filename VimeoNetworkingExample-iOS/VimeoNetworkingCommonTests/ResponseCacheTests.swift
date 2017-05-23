//
//  ResponseCacheTests.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Westendorf, Michael on 5/22/17.
//  Copyright © 2017 Vimeo. All rights reserved.
//

import XCTest
@testable import VimeoNetworking

class ResponseCacheTests: XCTestCase
{
    private let responseCache = ResponseCache(cacheDirectory: "com.vimeo.tests.Caches")
    
    override func setUp()
    {
        super.setUp()
        
        responseCache.clear()
    }
    
    func test_ResponseCache_CanStoreAndRetrieveResponse()
    {
        let request = Request<VIMCategory>(path: "/test/path")
        let categoryJSONDict = ResponseUtilities.loadResponse(from: "categories-animation-response.json")
        
        self.responseCache.setResponse(responseDictionary: categoryJSONDict!, forRequest: request)
        
        self.responseCache.response(forRequest: request) { result in
            switch result
            {
            case .success(let responseDictionary):
                XCTAssertNotNil(responseDictionary)
                
            case .failure(let error):
                XCTFail("\(error.localizedDescription)")
            }
        }
    }
    
    func test_ResponseCache_CanRemoveResponseFromCache()
    {
        let request1 = Request<VIMCategory>(path: "/test/path1")
        let request2 = Request<VIMCategory>(path: "/test/path2")
        
        let categoryJSONDict = ResponseUtilities.loadResponse(from: "categories-animation-response.json")
        
        self.responseCache.setResponse(responseDictionary: categoryJSONDict!, forRequest: request1)
        self.responseCache.setResponse(responseDictionary: categoryJSONDict!, forRequest: request2)
        
        self.responseCache.removeResponse(forKey: request1.cacheKey)
        
        self.responseCache.response(forRequest: request1) { result in
            switch result
            {
            case .success(let responseDictionary):
                XCTAssertNil(responseDictionary)
                
            case .failure(let error):
                XCTFail("\(error.localizedDescription)")
            }
        }
        
        self.responseCache.response(forRequest: request2) { result in
            switch result
            {
            case .success(let responseDictionary):
                XCTAssertNotNil(responseDictionary)
                
            case .failure(let error):
                XCTFail("\(error.localizedDescription)")
            }
        }
    }
 
    func test_ResponseCache_clearRemovesAllEntries()
    {
        let request1 = Request<VIMCategory>(path: "/test/path1")
        let request2 = Request<VIMCategory>(path: "/test/path2")
        
        let categoryJSONDict = ResponseUtilities.loadResponse(from: "categories-animation-response.json")
        
        self.responseCache.setResponse(responseDictionary: categoryJSONDict!, forRequest: request1)
        self.responseCache.setResponse(responseDictionary: categoryJSONDict!, forRequest: request2)
        
        self.responseCache.clear()
        
        self.responseCache.response(forRequest: request1) { result in
            switch result
            {
            case .success(let responseDictionary):
                XCTAssertNil(responseDictionary)
                
            case .failure(let error):
                XCTFail("\(error.localizedDescription)")
            }
        }
        
        self.responseCache.response(forRequest: request2) { result in
            switch result
            {
            case .success(let responseDictionary):
                XCTAssertNil(responseDictionary)
                
            case .failure(let error):
                XCTFail("\(error.localizedDescription)")
            }
        }
    }

}
