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

    private var json: VimeoClient.ResponseDictionary {
        guard let json = ResponseUtilities.loadResponse(
            from: "publish-to-social-connection.json"
        ) else {
            XCTFail()
            return [:]
        }

        return json
    }

    func test_publishBlockers_areParsedAsExpected() throws {
        let connection = try VIMObjectMapper.mapObject(responseDictionary: json) as PublishJobConnection

        XCTAssertEqual(connection.publishBlockers?.facebook, ["SIZE", "DURATION", "FB_NO_PAGES"])
        XCTAssertNil(connection.publishBlockers?.twitter)
        XCTAssertEqual(connection.publishBlockers?.linkedin, ["SIZE", "DURATION", "LI_NO_ORGANIZATIONS"])
        XCTAssertNil(connection.publishBlockers?.youtube)
    }

    func test_publishConstraints_areParsedAsExpected() throws {
        let connection = try VIMObjectMapper.mapObject(responseDictionary: json) as PublishJobConnection

        XCTAssertEqual(connection.publishConstraints?.facebook?.duration, 14400)
        XCTAssertEqual(connection.publishConstraints?.facebook?.size, 10737418240)
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
