//
//  Request+ConnectedAppTests.swift
//  VimeoNetworking
//
//  Copyright © 2019 Vimeo. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import XCTest
@testable import VimeoNetworking

class Request_ConnectedAppTests: XCTestCase {
    
    func test_connectedAppsRequest_returnsRequest_withExpectedURI() {
        let request = Request.connectedApps()
        XCTAssertEqual(request.path, "/me/connected_apps/")
    }
    
    func test_connectedApp_returnsExpectedURI_forFacebook() {
        let request = Request.connectedApp(.facebook)
        XCTAssertEqual(request.path, "/me/connected_apps/facebook")
    }
    
    func test_connectedApp_returnsExpectedURI_forTwitter() {
        let request = Request.connectedApp(.twitter)
        XCTAssertEqual(request.path, "/me/connected_apps/twitter")
    }
    
    func test_connectedApp_returnsExpectedURI_forYouTube() {
        let request = Request.connectedApp(.youtube)
        XCTAssertEqual(request.path, "/me/connected_apps/youtube")
    }
    
    func test_connectedApp_returnsExpectedURI_forLinkedIn() {
        let request = Request.connectedApp(.linkedin)
        XCTAssertEqual(request.path, "/me/connected_apps/linkedin")
    }
    
    func test_connectToFacebookRequest_returnsRequest_withExpectedTokenParameterKey() throws {
        let request = Request.connect(to: .facebook, with: "a1b2c3")
        XCTAssertEqual(request.method, .put)
        XCTAssertEqual(request.path, "/me/connected_apps/facebook")
        XCTAssertEqual(try XCTUnwrap(request.parameters) as? [String: String], ["auth_code":"a1b2c3"])
    }
    
    func test_connectToTwitterRequest_returnsRequest_withExpectedTokenParameterKey() throws {
        let request = Request.connect(to: .twitter, with: "a1b2c3")
        XCTAssertEqual(request.method, .put)
        XCTAssertEqual(request.path, "/me/connected_apps/twitter")
        XCTAssertEqual(try XCTUnwrap(request.parameters) as? [String: String], ["access_token_secret":"a1b2c3"])
    }
    
    func test_connectToYouTubeRequest_returnsRequest_withExpectedTokenParameterKey() throws {
        let request = Request.connect(to: .youtube, with: "a1b2c3")
        XCTAssertEqual(request.method, .put)
        XCTAssertEqual(request.path, "/me/connected_apps/youtube")
        XCTAssertEqual(try XCTUnwrap(request.parameters) as? [String: String], ["auth_code":"a1b2c3"])
    }
    
    func test_connectToLinkedInRequest_returnsRequest_withExpectedTokenParameterKey() throws {
        let request = Request.connect(to: .linkedin, with: "a1b2c3")
        XCTAssertEqual(request.method, .put)
        XCTAssertEqual(request.path, "/me/connected_apps/linkedin")
        XCTAssertEqual(try XCTUnwrap(request.parameters) as? [String: String], ["auth_code":"a1b2c3"])
    }
    
    func test_deleteConnectedApp_returnsExpectedHTTPMethod_andURI_forFacebook() {
        let request = Request.deleteConnectedApp(.facebook)
        XCTAssertEqual(request.method, .delete)
        XCTAssertEqual(request.path, "/me/connected_apps/facebook")
    }
    
    func test_deleteConnectedApp_returnsExpectedHTTPMethod_andURI_forTwitter() {
        let request = Request.deleteConnectedApp(.twitter)
        XCTAssertEqual(request.method, .delete)
        XCTAssertEqual(request.path, "/me/connected_apps/twitter")
    }
    
    func test_deleteConnectedApp_returnsExpectedHTTPMethod_andURI_forYouTube() {
        let request = Request.deleteConnectedApp(.youtube)
        XCTAssertEqual(request.method, .delete)
        XCTAssertEqual(request.path, "/me/connected_apps/youtube")
    }
    
    func test_deleteConnectedApp_returnsExpectedHTTPMethod_andURI_forLinkedIn() {
        let request = Request.deleteConnectedApp(.linkedin)
        XCTAssertEqual(request.method, .delete)
        XCTAssertEqual(request.path, "/me/connected_apps/linkedin")
    }
}
