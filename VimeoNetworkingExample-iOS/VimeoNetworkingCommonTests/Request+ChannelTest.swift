//
//  Request+ChannelTest.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Westendorf, Michael on 5/25/17.
//  Copyright © 2017 Vimeo. All rights reserved.
//

import XCTest
@testable import VimeoNetworking

class Request_ChannelTest: XCTestCase
{
    func test_Request_ValidateChannelRequest()
    {
        let request = ChannelRequest.getChannelRequest(forChannelURI: "/staffpicks")
        
        XCTAssertEqual(request.URI, "/staffpicks")
        XCTAssertTrue(RequestComparisons.ValidateDefaults(request: request))
    }
    
    func test_Request_ValidateChannelListRequest()
    {
        let request = ChannelListRequest.queryChannels(withQuery: "testQuery", refinements: ["test" : "refinement"])
        let testDict: VimeoClient.RequestParametersDictionary = ["query" : "testQuery", "test" : "refinement"]
        
        XCTAssertEqual(request.path, "/channels")
        XCTAssertEqual(request.URI, "/channels?query=testQuery&test=refinement")
        XCTAssertEqual(request.parameters as! [String : String], testDict as! [String : String])
    }
}
