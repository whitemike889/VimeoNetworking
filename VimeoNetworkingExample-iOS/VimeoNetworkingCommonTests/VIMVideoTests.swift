//
//  VIMVideoTests.swift
//  VimeoNetworkingExample-iOS
//
//  Copyright © 2017 Vimeo. All rights reserved.
//

import XCTest
@testable import VimeoNetworking

class VIMVideoTests: XCTestCase
{
    func test_isLive_returnsTrue_whenLiveObjectExists()
    {
        let liveDictionary: [String: Any] = ["link": "vimeo.com", "key": "abcdefg", "activeTime": Date(), "endedTime": Date(), "archivedTime": Date()]
        let testLiveObject = VIMLive(keyValueDictionary: liveDictionary)!
        
        let videoDictionary: [String: Any] = ["live": testLiveObject]
        let testVideoObject = VIMVideo(keyValueDictionary: videoDictionary)!
        
        XCTAssertNotNil(testLiveObject)
        XCTAssertNotNil(testVideoObject)
        XCTAssertTrue(testVideoObject.isLive())
    }
    
    func test_isLive_returnsFalse_whenLiveObjectDoesNotExist()
    {
        let videoDictionary: [String: Any] = ["link": "vimeo.com"]
        let testVideoObject = VIMVideo(keyValueDictionary: videoDictionary)!
        
        XCTAssertNotNil(testVideoObject)
        XCTAssertFalse(testVideoObject.isLive())
    }
}
