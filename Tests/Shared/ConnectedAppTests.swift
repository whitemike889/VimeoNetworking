//
//  ConnectedAppTests.swift
//  VimeoNetworking
//
//  Created by Vimeo on 11/7/19.
//  Copyright (c) Vimeo (https://vimeo.com)
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

class ConnectedAppTests: XCTestCase {
    func test_isDataAccessExpired_returnsTrue_whenTypeIsFacebook_andDataAccessIsExpired() {
        let json: [String: Any] = [
            "type": "facebook",
            "data_access_is_expired": true
        ]
        let connectedApp = try! VIMObjectMapper.mapObject(responseDictionary: json) as ConnectedApp
        XCTAssertEqual(connectedApp.type, .facebook)
        XCTAssertTrue(connectedApp.isDataAccessExpired)
    }

    func test_isDataAccessExpired_returnsFalse_whenTypeIsNotFacebook() {
        let json: [String: Any] = [
            "type": "youtube",
            "data_access_is_expired": true
        ]
        let connectedApp = try! VIMObjectMapper.mapObject(responseDictionary: json) as ConnectedApp
        XCTAssertNotEqual(connectedApp.type, .facebook)
        XCTAssertEqual(connectedApp.type, .youtube)
        XCTAssertFalse(connectedApp.isDataAccessExpired)
    }

    func test_type_returnsNone_whenTypeDataIsMalformed() {
        let json: [String: Any] = [
            "type": "friendster"
        ]
        let connectedApp = try! VIMObjectMapper.mapObject(responseDictionary: json) as ConnectedApp
        XCTAssertEqual(connectedApp.type, .none)
    }
}
