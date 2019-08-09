//
//  MetadataParsing.swift
//  VimeoNetworking
//
//  Created by Balatbat, Bryant on 7/30/18.
//

import Foundation

typealias Metadata = [AnyHashable: Any]

protocol MetadataParsing
{
    func parse<Keys: MetadataKeys, ModelType: VIMModelObject>(_ metadata: Metadata, type: MetadataType, mapping: [Keys: ModelType.Type]) -> [Keys: ModelType] where Keys.RawValue == String
}

extension MetadataParsing
{
    func parse<Keys: MetadataKeys, ModelType: VIMModelObject>(_ metadata: Metadata, type: MetadataType, mapping: [Keys: ModelType.Type] = [:]) -> [Keys: ModelType] where Keys.RawValue == String
    {
        guard let childMetadata = metadata[type.rawValue] as? [String: [AnyHashable: Any]] else
        {
            return [:]
        }
        
        return childMetadata.reduce([Keys: ModelType]()) { (partialResult, nextKeyValueTuple) -> [Keys: ModelType] in
            
            var partialResult = partialResult
            
            guard let key = Keys.init(rawValue: nextKeyValueTuple.key) else
            {
                return partialResult
            }
            
            let type = mapping[key] ?? ModelType.self
            
            if let model = type.init(keyValueDictionary: nextKeyValueTuple.value)
            {
                partialResult[key] = model
            }
            
            return partialResult
        }
    }
}

enum MetadataType: String
{
    case connections = "connections"
    case interactions = "interactions"
}
