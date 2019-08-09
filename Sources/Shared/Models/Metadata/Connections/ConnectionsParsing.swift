//
//  ConnectionsParsing.swift
//  VimeoNetworking
//
//  Created by Balatbat, Bryant on 7/30/18.
//

import Foundation

protocol ConnectionsParsing: MetadataParsing
{
    /// An associatedtype that will need to be defined as an enum String
    associatedtype ConnectionKeys: MetadataKeys where ConnectionKeys.RawValue == String
    
    /// Given Metadata, parses it into a dictionary of ConnectionKeys to VIMConnection
    ///
    /// - Parameter metadata: Metadata to be parsed
    /// - Returns: Dictionary that maps ConnectionKeys to VIMConnection
    func parse(_ metadata: Metadata) -> [ConnectionKeys: VIMConnection]
    
    /// Mapping used in cases where the connection key maps to a subclass of VIMConnection
    var connectionMapping: [ConnectionKeys: VIMConnection.Type] { get }
}

extension ConnectionsParsing
{
    func parse(_ metadata: Metadata) -> [ConnectionKeys: VIMConnection]
    {
        return parse(metadata, type: .connections, mapping: connectionMapping)
    }
}
