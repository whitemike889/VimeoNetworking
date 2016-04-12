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
        
        if let responseDictionary = self.memoryCache.responseDictionaryForKey(key)
        {
            do
            {
                let modelObject: ModelType = try VIMObjectMapper.mapObject(responseDictionary, modelKeyPath: request.modelKeyPath)
                let response = Response(model: modelObject)
                
                completion(result: .Success(result: response))
            }
            else
            catch let error
            {
                self.memoryCache.removeResponseDictionaryForKey(key)
                self.diskCache.removeResponseDictionaryForKey(key)
                
                completion(result: .Failure(error: error as NSError))
            }
        }
        else
        {
            self.diskCache.responseDictionaryForKey(key) { responseDictionary in
                
                if let responseDictionary = responseDictionary
                {
                    do
                    {
                        let modelObject: ModelType = try VIMObjectMapper.mapObject(responseDictionary, modelKeyPath: request.modelKeyPath)
                        let response = Response(model: modelObject)
                        
                        completion(result: .Success(result: response))
                    }
                    catch let error
                    {
                        self.diskCache.removeResponseDictionaryForKey(key)
                        
                        completion(result: .Failure(error: error as NSError))
                    }
                }
                else
                {
                    completion(result: .Success(result: nil))
                }
            }
        }
    }
    
    // MARK: - Memory Cache
    
    private let memoryCache = ResponseMemoryCache()
    
    private class ResponseMemoryCache
    {
        private let cache = NSCache()
        
        func setResponseDictionary(responseDictionary: VimeoClient.ResponseDictionary, forKey key: String)
        {
            self.cache.setObject(responseDictionary, forKey: key)
        }
        
        func responseDictionaryForKey(key: String) -> VimeoClient.ResponseDictionary?
        {
            let object = self.cache.objectForKey(key) as? VimeoClient.ResponseDictionary
            
            return object
        }
        
        func removeResponseDictionaryForKey(key: String)
        {
            self.cache.removeObjectForKey(key)
        }
    }
    
    // MARK: - Disk Cache
    
    private let diskCache = ResponseDiskCache()
    
    private class ResponseDiskCache
    {
        func setResponseDictionary(responseDictionary: VimeoClient.ResponseDictionary, forKey key: String)
        {
            
        }
        
        func responseDictionaryForKey(key: String, completion: (VimeoClient.ResponseDictionary? -> Void))
        {
            
        }
        
        func removeResponseDictionaryForKey(key: String)
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