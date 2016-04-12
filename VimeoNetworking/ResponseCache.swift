//
//  ResponseCache.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 3/29/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

final class ResponseCache
{
    func setResponse<ModelType>(responseDictionary: VimeoClient.ResponseDictionary, forRequest request: Request<ModelType>)
    {
        let key = request.cacheKey
        
        self.memoryCache.setResponseDictionary(responseDictionary, forKey: key)
        self.diskCache.setResponseDictionary(responseDictionary, forKey: key)
    }
    
    func responseForRequest<ModelType>(request: Request<ModelType>, completion: ResultCompletion<Response<ModelType>?>.T)
    {
        let key = request.cacheKey
        
        self.memoryCache.responseDictionaryForKey(key) { responseDictionary in
            
            if let responseDictionary = responseDictionary
            {
                // TODO: parse [RH] (4/12/16)
                
                completion(result: .Success(result: nil))
            }
            else
            {
                self.diskCache.responseDictionaryForKey(key) { responseDictionary in
                    
                    if let responseDictionary = responseDictionary
                    {
                        // TODO: parse [RH] (4/12/16)
                        
                        completion(result: .Success(result: nil))
                    }
                    else
                    {
                        completion(result: .Success(result: nil))
                    }
                }
            }
        }
    }
    
    // MARK: - Memory Cache
    
    private let memoryCache = ResponseMemoryCache()
    
    private class ResponseMemoryCache
    {
        func setResponseDictionary(object: VimeoClient.ResponseDictionary, forKey key: String)
        {
            
        }
        
        func responseDictionaryForKey(key: String, completion: (VimeoClient.ResponseDictionary? -> Void))
        {
            
        }
    }
    
    // MARK: - Disk Cache
    
    private let diskCache = ResponseDiskCache()
    
    private class ResponseDiskCache
    {
        func setResponseDictionary(object: VimeoClient.ResponseDictionary, forKey key: String)
        {
            
        }
        
        func responseDictionaryForKey(key: String, completion: (VimeoClient.ResponseDictionary? -> Void))
        {
            
        }
    }
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