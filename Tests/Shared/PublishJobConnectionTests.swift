//
//  PublishJobConnectionTests.swift
//  VimeoNetworking
//
//  Copyright © 2020 Vimeo. All rights reserved.
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

class PublishJobConnectionTests: XCTestCase {

    private var json: [String: Any] {
        let blockers: [String: Any] = [
            "facebook": ["SIZE", "DURATION", "FB_NO_PAGES"],
            "youtube": ["SIZE", "DURATION"],
            "linkedin": ["SIZE", "DURATION", "LI_NO_ORGANIZATIONS"],
            "twitter": ["SIZE", "DURATION"]
        ]

        let facebookConstraint: [String: Any] = [
            "duration": 14400,
            "size": 10
        ]

        let constraints: [String: Any] = [
            "facebook": facebookConstraint as Any
        ]

        let destinations: [String: Any] = [
            "facebook": true,
            "linkedin": false,
            "twitter": true,
            "youtube": false
        ]

        let connection: [String: Any] = [
            "publish_blockers": blockers as Any,
            "publish_constraints": constraints as Any,
            "publish_destinations": destinations as Any,
            "options": ["GET", "PUT"],
            "uri": ""
        ]

        return connection
    }

    func test_publishBlockers_areParsedAsExpected() throws {
        let connection = try VIMObjectMapper.mapObject(responseDictionary: json) as PublishJobConnection

        XCTAssertEqual(connection.publishBlockers?.facebook, ["SIZE", "DURATION", "FB_NO_PAGES"])
        XCTAssertEqual(connection.publishBlockers?.twitter, ["SIZE", "DURATION"])
        XCTAssertEqual(connection.publishBlockers?.linkedin, ["SIZE", "DURATION", "LI_NO_ORGANIZATIONS"])
        XCTAssertEqual(connection.publishBlockers?.youtube, ["SIZE", "DURATION"])
    }

    func test_publishConstraints_areParsedAsExpected() throws {
        let connection = try VIMObjectMapper.mapObject(responseDictionary: json) as PublishJobConnection

        XCTAssertEqual(connection.publishConstraints?.facebook?.duration, 14400)
        XCTAssertEqual(connection.publishConstraints?.facebook?.size, 10)
    }

    func test_publishDestinations_areParsedAsExpected() throws {
        let connection = try VIMObjectMapper.mapObject(responseDictionary: json) as PublishJobConnection

        XCTAssertTrue(try XCTUnwrap(connection.publishDestinations?.facebook))
        XCTAssertFalse(try XCTUnwrap(connection.publishDestinations?.linkedin))
        XCTAssertTrue(try XCTUnwrap(connection.publishDestinations?.twitter))
        XCTAssertFalse(try XCTUnwrap(connection.publishDestinations?.youtube))
    }

    func test_publishedDestinations_handleBadOrMissingValues() throws {
        let json: [String: Any] = [
            "facebook": false,
            "linkedin": true,
            "youtube": "published"
        ]

        let destinations = try VIMObjectMapper.mapObject(responseDictionary: json) as PublishJobDestinations

        XCTAssertFalse(destinations.facebook)
        XCTAssertTrue(destinations.linkedin)
        XCTAssertFalse(destinations.youtube)
        XCTAssertFalse(destinations.twitter)
    }
}
