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

public protocol MappableResponse
{
    static var mappingClass: AnyClass? { get }
    
    static var modelKeyPath: String? { get }
}

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

extension Array: MappableResponse
{
    // The default implementation for all arrays will return no mapping class or model key path
    // Only if Element itself is a VIMModelObject will the values be returned
    // This is because we can't restrict the generic type if we're
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
