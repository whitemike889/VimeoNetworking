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

    private var json: VimeoClient.ResponseDictionary {
        guard let json = ResponseUtilities.loadResponse(
            from: "publish-to-social-response.json"
        ) else {
            XCTFail()
            return [:]
        }

        return json
    }

    func test_publishJob_parsesAsExpected() throws {
        let publishJob = try VIMObjectMapper.mapObject(responseDictionary: json) as PublishJob
        XCTAssertNotNil(publishJob.firstPublishDate)
        XCTAssertNotNil(publishJob.resourceKey)
        XCTAssertNotNil(publishJob.destinations)
        XCTAssertEqual(publishJob.resourceKey, "43ccd2e018c0fc54feedf7fd19e018c0fc2897de")
    }

    func test_firstPublishDate_isFormattedCorrectly() throws {
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

    func test_publishJob_parsesPublishDestination_asExpected() throws {
        let publishJob = try VIMObjectMapper.mapObject(responseDictionary: json) as PublishJob
        XCTAssertNotNil(publishJob.destinations)
        XCTAssertNotNil(publishJob.destinations?.facebook)
        XCTAssertEqual(publishJob.destinations?.facebook?.status, .finished)
        XCTAssertEqual(publishJob.destinations?.facebook?.status?.description, "finished")
        XCTAssertEqual(publishJob.destinations?.facebook?.thirdPartyViewCount, 150)
        XCTAssertEqual(publishJob.destinations?.facebook?.thirdPartyLikeCount, 2)
        XCTAssertEqual(publishJob.destinations?.facebook?.thirdPartyCommentCount, 1)
        XCTAssertEqual(
            publishJob.destinations?.facebook?.thirdPartyPostURL,
            "https://facebook.com/150285126584258/videos/2452706093602193/"
        )
        XCTAssertEqual(publishJob.destinations?.facebook?.thirdPartyPostID, "2370929360645821")
    }
}
