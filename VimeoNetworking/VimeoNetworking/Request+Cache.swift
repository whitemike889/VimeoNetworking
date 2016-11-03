//
//  Request+Cache.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 4/14/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation


public extension Request
{
    /// Generates a unique cache key for a request, taking into account endpoint and parameters
    var cacheKey: String
    {
        var cacheKey = "cached" + self.path
        
        if let parameters = self.parameters
        {
            cacheKey = cacheKey + "." + String(parameters.description.hashValue)
        }
        
        cacheKey = cacheKey.stringByReplacingOccurrencesOfString("/", withString: ".")
        
        return cacheKey
    }
}
