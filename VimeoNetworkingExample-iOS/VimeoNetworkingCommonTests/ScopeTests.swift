//
//  ScopeTests.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Westendorf, Michael on 5/15/17.
//  Copyright © 2017 Vimeo. All rights reserved.
//

import XCTest
@testable import VimeoNetworking

class ScopeTests: XCTestCase
{
    func test_Scope_CombineReturnsSpaceSeparatedList()
    {
        XCTAssertEqual(Scope.combine([.Create, .Delete, .Edit, .Interact]), "create delete edit interact")
    }
}
