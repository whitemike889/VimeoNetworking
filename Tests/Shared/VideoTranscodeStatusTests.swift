//
//  VideoTranscodeStatusTests.swift
//  VimeoNetworking-iOSTests
//
//  Created by Nicole Lehrer on 12/10/19.
//  Copyright © 2019 Vimeo. All rights reserved.
//

import XCTest
@testable import VimeoNetworking

class VideoTranscodeStatusTests: XCTestCase {
    
    let mockWithAllValidData = Data("""
    {"state": "active", "progress": 50, "time_left": 5}
    """.utf8)
    
    let mockWithInvalidStatus = Data("""
    {"state": "bogusState", "progress": 50, "time_left": 5}
    """.utf8)
    
    let mockWithInvalidProgress = Data("""
    {"state": "active", "progress": 2000000000000000000000, "time_left": 5}
    """.utf8)

    let mockWithInvalidTimeLeft = Data("""
       {"state": "active", "progress": 50, "time_left": ""}
       """.utf8)
    
    // MARK: - Custom Decoder Tests

    func testCustomDecoder_decodesValidData() {
        do {
            let statusObject = try JSONDecoder().decode(VideoTranscodeStatus.self, from: mockWithAllValidData)
            XCTAssertTrue(statusObject.state == .active)
            XCTAssertTrue(statusObject.progress == 50)
            XCTAssertTrue(statusObject.timeLeft == 5)
        }
        catch let error {
            XCTFail("Custom decoding failed with unexpected \(error)")
        }
    }
    
    func testCustomDecoder_returnsDataCorruptedError_onInvalidStatus_asEmptyValue() {
        do {
            let _ = try JSONDecoder().decode(VideoTranscodeStatus.self, from: mockWithInvalidStatus)
            XCTFail("Custom decoding should have failed")
        }
        catch let DecodingError.dataCorrupted(context) {
            XCTAssertNotNil(context)
        }
        catch {
            XCTFail("Unexpected failure")
        }
     }
    
    func testCustomDecoder_returnsDataCorruptedError_onInvalidProgress_valueLargerThanIntSize() {
       do {
           let _ = try JSONDecoder().decode(VideoTranscodeStatus.self, from: mockWithInvalidProgress)
           XCTFail("Custom decoding should have failed")
       }
       catch let DecodingError.dataCorrupted(context) {
           XCTAssertNotNil(context)
       }
       catch {
           XCTFail("Unexpected failure")
       }
    }
    
    func testCustomDecoder_returnsTypeMismatchError_onInvalidTimeLeft_valueEmptyString() {
       do {
           let _ = try JSONDecoder().decode(VideoTranscodeStatus.self, from: mockWithInvalidTimeLeft)
           XCTFail("Custom decoding should have failed")
       }
       catch let DecodingError.typeMismatch(context) {
           XCTAssertNotNil(context)
       }
       catch {
           XCTFail("Unexpected failure")
       }
    }
    
    // MARK: - TranscodeStatusEndpointType Tests

    func testTranscodeStatusEndpointType_returnsCorrectURL() {
        let videoURI = "abc123"
        let expectedPath = VimeoBaseURL.appendingPathComponent(videoURI).appendingPathComponent("status")
        do {
            let urlRequest = try TranscodeStatusEndpointType(videoURI: videoURI).asURLRequest()
            XCTAssertTrue(urlRequest.url == expectedPath)
        }
        catch let error {
            XCTFail("Failed with error \(error)")
        }
    }
}
