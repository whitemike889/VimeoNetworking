//
//  MappableResponse.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 3/22/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation
import VIMObjectMapper

private let DefaultModelKeyPath = "data"

/**
 *  `MappableResponse` represents an object that can be automatically deserialized from a JSON response dictionary to a model object.  Conformance to this protocol allows a type to participate as the `ModelType` in a `Request`.  You should not adopt this protocol directly, but should subclass `VIMModelObject` for new models.  `VIMModelObject` as well as arrays with an element type of `VIMModelObject` conform to `MappableResponse`.  `VIMNullResponse` also conforms to this protocol, which allows for the representation of successful requests that intentionally return no response dictionary.
 */
public protocol MappableResponse
{
        /// Returns the class type used by `VIMObjectMapper` to deserialize the response
    static var mappingClass: AnyClass? { get }
    
        /// Optionally returns a nested JSON key to reference for mapping
    static var modelKeyPath: String? { get }
}

/**
 *  `VIMModelObject` conformance to `MappableResponse` enables all model objects derived from `VIMModelObject` to participate as the `ModelType` in a `Request`.
 */
extension VIMModelObject: MappableResponse
{
    public static var mappingClass: AnyClass?
    {
        return self
    }
    
    public static var modelKeyPath: String?
    {
        return nil
    }
}

/**
 *  `Array` conformance to `MappableResponse` enables arrays of any model object type to participate as the `ModelType` in a `Request`.
 */
extension Array: MappableResponse
{
    // The default implementation for all arrays will return no mapping class or model key path
    // Only if Element itself is a VIMModelObject will the values be returned
    // TODO: This is because we can't restrict the generic type if we're
    // extending a type with generics to conform to a protocol [RH]
    
    public static var mappingClass: AnyClass?
    {
        if Element.self is VIMModelObject.Type
        {
            return (Element.self as! AnyClass)
        }
        
        return nil
    }
    
    public static var modelKeyPath: String?
    {
        if Element.self is VIMModelObject.Type
        {
            return DefaultModelKeyPath
        }
        
        return nil
    }
}

/**
 *  `VIMNullResponse` is a model object containing no information. This allows for the representation of successful requests that intentionally return no response dictionary.
 */
public class VIMNullResponse: MappableResponse
{
    public static var mappingClass: AnyClass?
    {
        return self
    }
    
    public static var modelKeyPath: String?
    {
        return nil
    }
}
