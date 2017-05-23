//
//  Dictionary+ExtensionTests.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Westendorf, Michael on 5/22/17.
//  Copyright © 2017 Vimeo. All rights reserved.
//

import XCTest
@testable import VimeoNetworking

class Dictionary_ExtensionTests: XCTestCase
{
    func test_DictionaryExtension_AppendAddsNewItemsFromDictionary()
    {
        let comparisonDict = ["testKey1" : "testValue1", "testKey2" : "testValue2", "testKey3" : "testValue3"]
        
        var dictionary = ["testKey1" : "testValue1"]
        dictionary.append(["testKey2" : "testValue2", "testKey3" : "testValue3"])
        
        XCTAssertEqual(dictionary, comparisonDict)
    }
}
