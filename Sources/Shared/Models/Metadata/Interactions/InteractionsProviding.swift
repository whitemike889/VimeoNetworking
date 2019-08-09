//
//  InteractionsProviding.swift
//  VimeoNetworking
//
//  Created by Balatbat, Bryant on 7/30/18.
//

import Foundation

public protocol InteractionsProviding
{
    associatedtype InteractionsKeys: MetadataKeys where InteractionsKeys.RawValue == String
    
    var interactions: [InteractionsKeys: VIMInteraction] { get }
}
