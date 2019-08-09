//
//  InteractionsParsing.swift
//  VimeoNetworking
//
//  Created by Balatbat, Bryant on 7/30/18.
//

import Foundation

protocol InteractionsParsing: MetadataParsing
{
    associatedtype InteractionsKeys: MetadataKeys where InteractionsKeys.RawValue == String
    
    func parse(_ metadata: Metadata) -> [InteractionsKeys: VIMConnection]
}

extension InteractionsParsing
{
    func parse(_ metadata: Metadata) -> [InteractionsKeys: VIMConnection]
    {
        return parse(metadata, type: .interactions)
    }
}
