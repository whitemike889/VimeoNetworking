//
//  MappableResponse.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 3/22/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

private let DefaultModelKeyPath = "data"

public protocol MappableResponse
{
    static var mappingClass: AnyClass? { get }
    
    static var modelKeyPath: String? { get }
    
    func validateModel() throws
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
    
    public func validateModel() throws
    {
        var error: NSError? = nil
        
        self.validateModel(&error)
        
        if let error = error
        {
            throw error
        }
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
    
    public func validateModel() throws
    {
        for model in self
        {
            guard let model = model as? VIMModelObject
            else
            {
                let description = "Mappable array does not have an element type inheriting from VIMModelObject"
                let error = NSError(domain: VIMModelObjectErrorDomain, code: VIMModelObjectValidationErrorCode, userInfo: [NSLocalizedDescriptionKey: description])
                
                throw error
            }
            
            var error: NSError? = nil
            
            model.validateModel(&error)
            
            if let error = error
            {
                throw error
            }
        }
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
    
    public func validateModel() throws
    {
        // NO-OP: a null response object is always valid
    }
}
