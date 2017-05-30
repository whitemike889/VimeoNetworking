//
//  Request+CommentTest.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Westendorf, Michael on 5/25/17.
//  Copyright © 2017 Vimeo. All rights reserved.
//

import XCTest
@testable import VimeoNetworking

class Request_CommentTest: XCTestCase
{
    func test_RequestComment_ValidatePostCommentRequest()
    {
        let request = Request<VIMComment>.postCommentRequest(forURI: "/comment/path", text: "Test Comment")
        let testParamsDict: VimeoClient.RequestParametersDictionary = ["text" : "Test Comment"]
        
        XCTAssertEqual(request.method, .POST)
        XCTAssertEqual(request.path, "/comment/path")
        XCTAssertEqual(request.URI, "/comment/path?text=Test%20Comment")
        XCTAssertEqual(request.parameters as! [String : String], testParamsDict as! [String : String])
    }
}
