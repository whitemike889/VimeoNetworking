//
//  VimeoClient.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 3/21/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

final class VimeoClient
{
    // MARK: - 
    
    enum Method: String
    {
        case GET
        case POST
        case PUT
        case PATCH
        case DELETE
    }
    
    struct RequestToken
    {
        private let task: NSURLSessionDataTask
        
        func cancel()
        {
            self.task.cancel()
        }
    }
    
    typealias RequestParameters = [String: String]
    typealias ResponseDictionary = [String: AnyObject]
    
    static let ErrorDomain = "VimeoClientErrorDomain"
    
    // TODO: make these an enum [RH] (3/30/16)
    static let ErrorInvalidDictionary = 1001
    static let ErrorRequestMalformed = 1004
    static let ErrorUndefined = 1009
    
    // MARK: -
    
    private let sessionManager: VimeoSessionManager
    
    init(appConfiguration: AppConfiguration)
    {
        self.sessionManager = VimeoSessionManager.defaultSessionManager(appConfiguration: appConfiguration)
    }
    
    // MARK: - Authentication
    
    var authenticatedAccount: VIMAccountNew?
    {
        didSet
        {
            if let authenticatedAccount = self.authenticatedAccount
            {
                self.sessionManager.clientDidAuthenticateWithAccount(authenticatedAccount)
            }
            else
            {
                self.sessionManager.clientDidClearAccount()
            }
        }
    }
    
    var authenticatedUser: VIMUser?
    {
        return self.authenticatedAccount?.user
    }
    
    var isAuthenticated: Bool
    {
        return self.authenticatedAccount?.isAuthenticated() ?? false
    }
    
    var isAuthenticatedWithUser: Bool
    {
        return self.authenticatedAccount?.isAuthenticatedWithUser() ?? false
    }
    
    var isAuthenticatedWithClientCredentials: Bool
    {
        return self.authenticatedAccount?.isAuthenticatedWithClientCredentials() ?? false
    }
    
    // MARK: - Request
    
    func request<ModelType: MappableResponse>(request: Request<ModelType>, completionQueue: dispatch_queue_t = dispatch_get_main_queue(), completion: ResultCompletion<Response<ModelType>>.T) -> RequestToken?
    {
        let urlString = request.path
        let parameters = request.parameters
        
        let success: (NSURLSessionDataTask, AnyObject?) -> Void = { (task, responseObject) in
            self.handleRequestSuccess(request: request, task: task, responseObject: responseObject, completionQueue: completionQueue, completion: completion)
        }
        
        let failure: (NSURLSessionDataTask?, NSError) -> Void = { (task, error) in
            self.handleRequestFailure(request: request, task: task, error: error, completionQueue: completionQueue, completion: completion)
        }
        
        let task: NSURLSessionDataTask?
        
        switch request.method
        {
        case .GET:
            task = self.sessionManager.GET(urlString, parameters: parameters, success: success, failure: failure)
        case .POST:
            task = self.sessionManager.POST(urlString, parameters: parameters, success: success, failure: failure)
        case .PUT:
            task = self.sessionManager.PUT(urlString, parameters: parameters, success: success, failure: failure)
        case .PATCH:
            task = self.sessionManager.PATCH(urlString, parameters: parameters, success: success, failure: failure)
        case .DELETE:
            task = self.sessionManager.DELETE(urlString, parameters: parameters, success: success, failure: failure)
        }
        
        guard let requestTask = task
        else
        {
            let description = "Session manager did not return a task"
            
            assertionFailure(description)
            
            let error = NSError(domain: self.dynamicType.ErrorDomain, code: self.dynamicType.ErrorRequestMalformed, userInfo: [NSLocalizedDescriptionKey: description])
            
            self.handleRequestFailure(request: request, task: task, error: error, completionQueue: completionQueue, completion: completion)
            
            return nil
        }
        
        return RequestToken(task: requestTask)
    }
    
    private func handleRequestSuccess<ModelType: MappableResponse>(request request: Request<ModelType>, task: NSURLSessionDataTask, responseObject: AnyObject?, completionQueue: dispatch_queue_t, completion: ResultCompletion<Response<ModelType>>.T)
    {
        guard let responseDictionary = responseObject as? ResponseDictionary
        else
        {
            if ModelType.self == VIMNullResponse.self
            {
                let nullResponseObject = VIMNullResponse()
                
                // Swift complains that this cast always fails, but it doesn't seem to ever actually fail, and it's required to call completion with this response [RH] (4/12/2016)
                let response = Response(model: nullResponseObject) as! Response<ModelType>

                dispatch_async(completionQueue)
                {
                    completion(result: .Success(result: response as Response<ModelType>))
                }
            }
            else
            {
                let description = "VimeoClient requestSuccess returned invalid/absent dictionary"
                
                assertionFailure(description)
                
                let error = NSError(domain: self.dynamicType.ErrorDomain, code: self.dynamicType.ErrorInvalidDictionary, userInfo: [NSLocalizedDescriptionKey: description])
                
                self.handleRequestFailure(request: request, task: task, error: error, completionQueue: completionQueue, completion: completion)
            }
            
            return
        }
        
        do
        {
            let modelObject: ModelType = try VIMObjectMapper.mapObject(responseDictionary, modelKeyPath: request.modelKeyPath)
            
            dispatch_async(completionQueue)
            {
                completion(result: .Success(result: Response<ModelType>(model: modelObject)))
            }
        }
        catch let error
        {
            self.handleRequestFailure(request: request, task: task, error: error as? NSError, completionQueue: completionQueue, completion: completion)
        }
    }
    
    private func handleRequestFailure<ModelType: MappableResponse>(request request: Request<ModelType>, task: NSURLSessionDataTask?, error: NSError?, completionQueue: dispatch_queue_t, completion: ResultCompletion<Response<ModelType>>.T)
    {
        let error = error ?? NSError(domain: self.dynamicType.ErrorDomain, code: self.dynamicType.ErrorUndefined, userInfo: [NSLocalizedDescriptionKey: "Undefined error"])
        
        if error.code == NSURLErrorCancelled
        {
            return
        }
        
        // TODO: Intercept errors globally [RH] (3/29/16)
        
        dispatch_async(completionQueue)
        {
            completion(result: .Failure(error: error))
        }
    }
}

