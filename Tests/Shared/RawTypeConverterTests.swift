//
//  RawTypeConverterTests.swift
//  VimeoNetworking-iOSTests
//
//  Created by Nicole Lehrer on 10/11/19.
//  Copyright © 2019 Vimeo. All rights reserved.
//

import XCTest

class RawTypeConverterTests: XCTestCase {

    func test_RawTypeConverter_returnsCorrectString_forBoolFalse() {
        let aBool = false
        let aBoolAsString = RawTypeConverter.string(from: aBool)
        XCTAssertEqual(aBoolAsString, "false")
    }

    func test_RawTypeConverter_returnsCorrectString_forBoolTrue() {
        let aBool = true
        let aBoolAsString = RawTypeConverter.string(from: aBool)
        XCTAssertEqual(aBoolAsString, "true")
    }
}
