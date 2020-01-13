//
//  PublishJobTests.swift
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

class PublishJobTests: XCTestCase {
    func test_publishJob_parsesAsExpected() throws {
        let json: [String: Any] = [
            "first_publish_date": "2015-12-17T21:32:44+00:00",
            "destinations": "",
            "resource_key": "3ebd4a2becabbee30ca2baae3a23cebca1137063"
        ]

        let publishJob = try VIMObjectMapper.mapObject(responseDictionary: json) as PublishJob
        XCTAssertNotNil(publishJob.firstPublishDate)
        XCTAssertNotNil(publishJob.resourceKey)
        XCTAssertEqual(publishJob.resourceKey, "3ebd4a2becabbee30ca2baae3a23cebca1137063")
    }

    func test_firstPublishDate_isFormattedCorrectly() throws {
        let json: [String: Any] = [
            "first_publish_date": "2015-12-17T21:32:44+00:00",
            "destinations": "",
            "resource_key": "03c2e13be74abec3a3aeba223ae6cd01b3caebba"
        ]

        let publishJob = try VIMObjectMapper.mapObject(responseDictionary: json) as PublishJob
        var calendar = Calendar.current
        TimeZone(secondsFromGMT: 0).map { calendar.timeZone = $0 }
        let year = try calendar.component(.year, from: XCTUnwrap(publishJob.firstPublishDate))
        let month = try calendar.component(.month, from: XCTUnwrap(publishJob.firstPublishDate))
        let day = try calendar.component(.day, from: XCTUnwrap(publishJob.firstPublishDate))
        let hour = try calendar.component(.hour, from: XCTUnwrap(publishJob.firstPublishDate))
        let minute = try calendar.component(.minute, from: XCTUnwrap(publishJob.firstPublishDate))
        let second = try calendar.component(.second, from: XCTUnwrap(publishJob.firstPublishDate))

        XCTAssertEqual(year, 2015)
        XCTAssertEqual(month, 12)
        XCTAssertEqual(day, 17)
        XCTAssertEqual(hour, 21)
        XCTAssertEqual(minute, 32)
        XCTAssertEqual(second, 44)
    }

    func test_publishJob_parsesPublishDestinations_asExpected() throws {
        let youtube: [String: Any] = [
            "status": "finished",
            "third_party_post_url": "https://www.youtube.com/watch?v=i72F_nPdLoz",
            "third_party_post_id": "i72F_nPdLoz"
        ]

        let destinations: [String: Any] = [
            "youtube": youtube as Any
        ]

        let job: [String: Any] = [
            "first_publish_date": "2015-12-17T21:32:44+00:00",
            "destinations": destinations as Any,
            "resource_key": "03c2e13be74abec3a3aeba223ae6cd01b3caebba"
        ]

        let publishJob = try VIMObjectMapper.mapObject(responseDictionary: job) as PublishJob
        XCTAssertNotNil(publishJob.destinations)
        XCTAssertNotNil(publishJob.destinations?.youtube)
        XCTAssertEqual(publishJob.destinations?.youtube?.status, .finished)
        XCTAssertEqual(publishJob.destinations?.youtube?.status?.description, "finished")
        XCTAssertEqual(
            publishJob.destinations?.youtube?.thirdPartyPostURL,
            "https://www.youtube.com/watch?v=i72F_nPdLoz"
        )
        XCTAssertEqual(publishJob.destinations?.youtube?.thirdPartyPostID, "i72F_nPdLoz")
    }
}
