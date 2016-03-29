//
//  ResponseCache.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 3/29/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

class ResponseCache
{
    typealias CacheCompletion = (response: VimeoClient.ResponseDictionary?) -> Void
    
    func setResponse<ModelType>(response: VimeoClient.ResponseDictionary, forRequest request: Request<ModelType>)
    {
        // TODO: [RH] (3/29/16)
    }
    
    func responseForRequest<ModelType>(request: Request<ModelType>, completion: CacheCompletion)
    {
        // TODO: [RH] (3/29/16)
        
        completion(response: nil)
    }
    
    // MARK: - Memory Cache
    
    // TODO:  [RH] (3/29/16)
    
    // MARK: - Disk Cache
    
    // TODO:  [RH] (3/29/16)
}

extension Request
{
    var cacheKey: String
    {
        var cacheKey = self.path
        
        if let parameters = self.parameters
        {
            for (key, value) in parameters
            {
                cacheKey += key
                cacheKey += value
            }
        }
        
        // TODO: MD5 this jank [RH] (3/29/16)
        
        return cacheKey
    }
}