//
//  Model.swift
//  Videos
//
//  Created by King, Gavin on 2/5/18.
//  Copyright © 2018 Vimeo. All rights reserved.
//

import Foundation

public protocol Model: Codable, Filtered, Equatable
{
    
}

// MARK: Special Models

public protocol UniqueModel: Model
{
    var resourceKey: String { get }
    
    var uri: String { get }
}

// MARK: Model Capability Protocols

public protocol Filtered
{
    static func filters() -> [String]
}

// MARK: Helper Functions

// TODO: Remove this and add Hashable support for Swift 4.1 Conditional Conformance: https://swift.org/blog/conditional-conformance/

func ==<T: Equatable>(lhs: [T]?, rhs: [T]?) -> Bool {
    switch (lhs,rhs) {
    case (.some(let lhs), .some(let rhs)):
        return lhs == rhs
    case (.none, .none):
        return true
    default:
        return false
    }
}
