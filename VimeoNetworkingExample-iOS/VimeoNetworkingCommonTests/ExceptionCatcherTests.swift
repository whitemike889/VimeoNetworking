//
//  ExceptionCatcherTests.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Westendorf, Michael on 5/22/17.
//  Copyright © 2017 Vimeo. All rights reserved.
//

import XCTest
@testable import VimeoNetworking

class ExceptionCatcherTests: XCTestCase
{
    func test_ExceptionCatcher_CatchesArchiverExceptions()
    {
        do
        {
            try ExceptionCatcher.doUnsafe
            {
                let exception = NSException(name: NSExceptionName.invalidArchiveOperationException, reason: "test exception", userInfo: nil)
                exception.raise()
            }
        }
        catch let error
        {
            XCTAssertEqual(error.localizedDescription, "test exception")
            return
        }
        
        XCTFail("This test should throw an exception!")
    }
}
