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
        let badData = Data(repeating: 1, count: 20)
        
        do
        {
            try ExceptionCatcher.doUnsafe
            {
                _ = NSKeyedUnarchiver.unarchiveObject(with: badData) as? VimeoClient.ResponseDictionary
            }
        }
        catch let error
        {
            XCTAssertEqual(error.localizedDescription, NSExceptionName.invalidArchiveOperationException.rawValue)
        }
        
//        XCTFail("This test should throw an exception!")
    }
}
