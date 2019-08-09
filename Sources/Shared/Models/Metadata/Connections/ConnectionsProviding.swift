//
//  ConnectionsProviding.swift
//  VimeoNetworking
//
//  Created by Balatbat, Bryant on 7/30/18.
//

import Foundation

protocol ConnectionsProviding
{
    associatedtype ConnectionKeys: MetadataKeys where ConnectionKeys.RawValue == String
    
    var connections: [ConnectionKeys: VIMConnection] { get }
}
