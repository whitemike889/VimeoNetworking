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

    func test_isDataAccessExpired_returnsFalse_whenTypeIsFacebook_andDataAccessIsNotExpired() {
        let json: [String: Any] = [
            "type": "facebook",
            "data_access_is_expired": false
        ]
        let connectedApp = try! VIMObjectMapper.mapObject(responseDictionary: json) as ConnectedApp
        XCTAssertEqual(connectedApp.type, .facebook)
        XCTAssertFalse(connectedApp.isDataAccessExpired)
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

    func test_isDataAccessExpired_returnsTrue_whenDataAccessIsExpired_isMissingFromResponse() {
        let json: [String: Any] = [
            "type": "facebook"
        ]
        let connectedApp = try! VIMObjectMapper.mapObject(responseDictionary: json) as ConnectedApp
        XCTAssertTrue(connectedApp.isDataAccessExpired)
    }

    func test_connectedAppType_returnsExpectedStringValue_forFacebookAppType() {
        let json: [String: Any] = [
            "type": "facebook"
        ]
        let connectedApp = try! VIMObjectMapper.mapObject(responseDictionary: json) as ConnectedApp
        XCTAssertEqual(connectedApp.type?.stringValue, "facebook")
    }

    func test_connectedAppType_returnsExpectedStringValue_forYouTubeAppType() {
        let json: [String: Any] = [
            "type": "youtube"
        ]
        let connectedApp = try! VIMObjectMapper.mapObject(responseDictionary: json) as ConnectedApp
        XCTAssertEqual(connectedApp.type?.stringValue, "youtube")
    }

    func test_connectedAppType_returnsExpectedStringValue_forTwitterAppType() {
        let json: [String: Any] = [
            "type": "twitter"
        ]
        let connectedApp = try! VIMObjectMapper.mapObject(responseDictionary: json) as ConnectedApp
        XCTAssertEqual(connectedApp.type?.stringValue, "twitter")
    }

    func test_connectedAppType_returnsExpectedStringValue_forLinkedInAppType() {
        let json: [String: Any] = [
            "type": "linkedin"
        ]
        let connectedApp = try! VIMObjectMapper.mapObject(responseDictionary: json) as ConnectedApp
        XCTAssertEqual(connectedApp.type?.stringValue, "linkedin")
    }

    func test_connectedAppType_returnsNil_whenTypeIsUnexpected() {
        let json: [String: Any] = [
            "type": "friendster"
        ]
        let connectedApp = try! VIMObjectMapper.mapObject(responseDictionary: json) as ConnectedApp
        XCTAssertNil(connectedApp.type)
        XCTAssertNil(connectedApp.type?.stringValue)
    }

    func test_connectedApp_returnsExpectedPublishCategories_fromInputPublishOptionItems() {
        let artDict: [String: Any] = [
            "identifier": 12345,
            "name": "art"
        ]
        let vacationDict: [String: Any] = [
            "identifier": 67890,
            "name": "vacation"
        ]

        let art = PublishOptionItem(keyValueDictionary: artDict)
        let vacation = PublishOptionItem(keyValueDictionary: vacationDict)

        let connectedAppDict: [String: Any] = [
            "publishCategories": [art, vacation] as Any
        ]
        let connectedApp = ConnectedApp(keyValueDictionary: connectedAppDict)!

        XCTAssertNotNil(connectedApp.publishCategories)
        XCTAssertEqual(connectedApp.publishCategories?.count, 2)
        XCTAssertEqual(connectedApp.publishCategories![0].name, "art")
        XCTAssertEqual(connectedApp.publishCategories![0].identifier, 12345)
        XCTAssertEqual(connectedApp.publishCategories![1].name, "vacation")
        XCTAssertEqual(connectedApp.publishCategories![1].identifier, 67890)
    }
}
