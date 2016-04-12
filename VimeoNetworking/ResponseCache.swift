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
        private let queue = dispatch_queue_create("com.vimeo.VIMCache.diskQueue", DISPATCH_QUEUE_CONCURRENT)
        
        func setResponseDictionary(responseDictionary: VimeoClient.ResponseDictionary, forKey key: String)
        {
            let data = NSKeyedArchiver.archivedDataWithRootObject(responseDictionary)
            
            dispatch_barrier_async(self.queue) { 
                
                let fileManager = NSFileManager()
                
                let directoryURL = self.documentsDirectoryURL()
                let fileURL = self.fileURLForKey(key: key)
                
                guard let directoryPath = directoryURL.path,
                    let filePath = fileURL.path
                else
                {
                    assertionFailure("no cache path found: \(fileURL)")
                    
                    return
                }
                
                do
                {
                    if !fileManager.fileExistsAtPath(directoryPath)
                    {
                        try fileManager.createDirectoryAtPath(directoryPath, withIntermediateDirectories: true, attributes: nil)
                    }
                    
                    let success = fileManager.createFileAtPath(filePath, contents: data, attributes: nil)
                    
                    if !success
                    {
                        print("ResponseDiskCache could not store object")
                    }
                }
                catch let error
                {
                    print("ResponseDiskCache error: \(error)")
                }
            }
        }
        
        func responseDictionaryForKey(key: String, completion: (VimeoClient.ResponseDictionary? -> Void))
        {
            dispatch_async(self.queue) {
                
                let fileURL = self.fileURLForKey(key: key)
                
                guard let filePath = fileURL.path
                    else
                {
                    assertionFailure("no cache path found: \(fileURL)")
                    
                    return
                }
                
                guard let data = NSData(contentsOfFile: filePath)
                else
                {
                    completion(nil)
                    
                    return
                }
                
                if let responseDictionary = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? VimeoClient.ResponseDictionary
                {
                    completion(responseDictionary)
                }
                else
                {
                    completion(nil)
                }
            }
        }
        
        func removeResponseDictionaryForKey(key: String)
        {
            dispatch_async(self.queue) {
                
                let fileManager = NSFileManager()
                
                let fileURL = self.fileURLForKey(key: key)
                
                guard let filePath = fileURL.path
                    else
                {
                    assertionFailure("no cache path found: \(fileURL)")
                    
                    return
                }
                
                do
                {
                    try fileManager.removeItemAtPath(filePath)
                }
                catch
                {
                    print("could not remove disk cache for \(key)")
                }
            }
        }
        
        // MARK: - copied from ArchiveStore
        
//        func setData(data: NSData, forKey key: String) throws
//        {
//            let fileURL = self.fileURLForKey(key: key)
//            
//            guard let filePath = fileURL.path
//                else
//            {
//                let error = NSError(domain: "ArchiveStoreDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "no path"])
//                throw error
//            }
//            
//            if let documentsDirectoryURL = self.documentsDirectoryURL()
//            {
//                try self.fileManager.createDirectoryAtURL(documentsDirectoryURL, withIntermediateDirectories: true, attributes: nil)
//            }
//            
//            if self.fileManager.fileExistsAtPath(filePath)
//            {
//                try self.fileManager.removeItemAtPath(filePath)
//            }
//            
//            let success = self.fileManager.createFileAtPath(filePath, contents: data, attributes: nil)
//            
//            if !success
//            {
//                let error = NSError(domain: "ArchiveStoreDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "create file failed"])
//                throw error
//            }
//        }
//        
//        func dataForKey(key: String) throws -> NSData?
//        {
//            let data = NSData(contentsOfURL: self.fileURLForKey(key: key))
//            
//            return data
//        }
//        
//        func deleteDataForKey(key: String) throws
//        {
//            try self.fileManager.removeItemAtURL(self.fileURLForKey(key: key))
//        }
        
        private func documentsDirectoryURL() -> NSURL
        {
            guard let directory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first
            else
            {
                fatalError("no documents directories found")
            }
            
            return NSURL(fileURLWithPath: directory)
        }
        
        private func fileURLForKey(key key: String) -> NSURL
        {
            let directoryURL = self.documentsDirectoryURL()
            
            let fileURL = directoryURL.URLByAppendingPathComponent(key)
            
            return fileURL
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