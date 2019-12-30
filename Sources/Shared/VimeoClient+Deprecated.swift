//
//  VimeoClient+Deprecated.swift
//  VimeoNetworking
//
//  Created by Rogerio Assis on 12/29/19.
//  Copyright © 2019 Vimeo. All rights reserved.
//

import Foundation
import Model

extension VimeoClient {
    
    /// Executes a `Request`
    ///
    /// - Parameters:
    ///   - request: `Request` object containing all the required URL and policy information
    ///   - startImmediately: a boolean indicating whether or not the request should resume immediately
    ///   - completionQueue: dispatch queue on which to execute the completion closure
    ///   - completion: a closure executed one or more times, containing a `Result`
    ///
    /// - Returns: a `RequestToken` for the in-flight request
    public func request<ModelType>(
        _ request: Request<ModelType>,
        startImmediately: Bool = true,
        completionQueue: DispatchQueue = .main,
        completion: @escaping ResultCompletion<Response<ModelType>, NSError>.T
    ) -> RequestToken {
        if request.useCache {
            return self.cachedResponse(
                for: request,
                completionQueue: completionQueue,
                then: completion
            )
        } else {
            let requestToken = self.create(
                request,
                completionQueue: completionQueue,
                then: completion
            )
            if startImmediately { requestToken.resume() }
            return requestToken
        }
    }
    
    /// Removes any cached responses for a given `Request`
    /// - Parameters:
    ///   - key: the cache key for which to remove all cached responses
    public func removeCachedResponse(forKey key: String) {
        self.responseCache.removeResponse(forKey: key)
    }
    
    /// Clears a client's cache of all stored responses
    public func removeAllCachedResponses() {
        self.responseCache.clear()
    }
}

extension VimeoClient {
    
    private func create<ModelType>(
        _ request: Request<ModelType>,
        completionQueue: DispatchQueue,
        then callback: @escaping ResultCompletion<Response<ModelType>, NSError>.T
    ) -> RequestToken {
        let task = self.sessionManager?.request(
            request,
            parameters: request.parameters,
            then: { (sessionManagingResult: SessionManagingResult<JSON>) in
                DispatchQueue.global(qos: .userInitiated).async {
                    switch sessionManagingResult.result {
                    case .success(let JSON):
                        self.handleTaskSuccess(
                            for: request,
                            urlRequest: sessionManagingResult.request,
                            responseObject: JSON,
                            completionQueue: completionQueue,
                            completion: callback
                        )
                    case .failure(let error):
                        self.handleTaskFailure(
                            for: request,
                            urlRequest: sessionManagingResult.request,
                            error: error as NSError,
                            completionQueue: completionQueue,
                            completion: callback
                        )
                    }
                }
            }
        )

        guard let requestTask = task else {
            let description = "Session manager did not return a task"
            assertionFailure(description)

            let error = NSError(
                domain: type(of: self).ErrorDomain,
                code: LocalErrorCode.requestMalformed.rawValue,
                userInfo: [NSLocalizedDescriptionKey: description]
            )
            self.handleTaskFailure(
                for: request,
                urlRequest: nil,
                error: error,
                completionQueue: completionQueue,
                completion: callback
            )
            return RequestToken(path: request.path, task: nil)
        }

        return RequestToken(path: request.path, task: requestTask)
    }

    // MARK: - Private cache response handling

    private func cachedResponse<ModelType>(
        for request: Request<ModelType>,
        completionQueue: DispatchQueue,
        then callback: @escaping ResultCompletion<Response<ModelType>, NSError>.T
    ) -> RequestToken {
        self.responseCache.response(forRequest: request) { result in
            switch result {
            case .success(let responseDictionary):
                if let responseDictionary = responseDictionary {
                    self.handleTaskSuccess(
                        for: request,
                        urlRequest: nil,
                        responseObject: responseDictionary,
                        isCachedResponse: true,
                        completionQueue: completionQueue,
                        completion: callback
                    )
                } else {
                    let error = NSError(
                        domain: type(of: self).ErrorDomain,
                        code: LocalErrorCode.cachedResponseNotFound.rawValue,
                        userInfo: [NSLocalizedDescriptionKey: "Cached response not found"]
                    )
                    self.handleError(error, request: request)

                    completionQueue.async {
                        callback(.failure(error))
                    }
                }

            case .failure(let error):
                self.handleError(error, request: request)

                completionQueue.async {
                    callback(.failure(error))
                }
            }
        }
        return RequestToken(path: request.path, task: nil)
    }

    // MARK: - Private task completion handlers
    
    private func handleTaskSuccess<ModelType>(
        for request: Request<ModelType>,
        urlRequest: URLRequest?,
        responseObject: Any,
        isCachedResponse: Bool = false,
        completionQueue: DispatchQueue,
        completion: @escaping ResultCompletion<Response<ModelType>, NSError>.T
    ) {
        guard
            let responseDictionary = responseObject as? ResponseDictionary,
            responseDictionary.isEmpty == false else {

            if ModelType.self == VIMNullResponse.self {
                let nullResponseObject = VIMNullResponse()
                
                // Swift complains that this cast always fails, but it doesn't seem to ever actually fail, and it's required to call completion with this response [RH] (4/12/2016)
                // It's also worth noting that (as of writing) there's no way to direct the compiler to ignore specific instances of warnings in Swift :S [RH] (4/13/16)
                let response = Response(model: nullResponseObject, json: [:]) as! Response<ModelType>

                completionQueue.async {
                    completion(.success(response as Response<ModelType>))
                }
            } else {
                let description = "VimeoClient requestSuccess returned invalid/absent dictionary"
                assertionFailure(description)
                let error = NSError(
                    domain: type(of: self).ErrorDomain,
                    code: LocalErrorCode.invalidResponseDictionary.rawValue,
                    userInfo: [NSLocalizedDescriptionKey: description]
                )
                self.handleTaskFailure(
                    for: request,
                    urlRequest: urlRequest,
                    error: error,
                    completionQueue: completionQueue,
                    completion: completion
                )
            }
            
            return
        }
        
        do {
            let modelObject: ModelType = try VIMObjectMapper.mapObject(responseDictionary: responseDictionary, modelKeyPath: request.modelKeyPath)
            
            var response: Response<ModelType>
            
            if let pagingDictionary = responseDictionary[.pagingKey] as? ResponseDictionary {
                let totalCount = responseDictionary[.totalKey] as? Int ?? 0
                let currentPage = responseDictionary[.pageKey] as? Int ?? 0
                let itemsPerPage = responseDictionary[.perPageKey] as? Int ?? 0
                
                var nextPageRequest: Request<ModelType>? = nil
                var previousPageRequest: Request<ModelType>? = nil
                var firstPageRequest: Request<ModelType>? = nil
                var lastPageRequest: Request<ModelType>? = nil
                
                if let nextPageLink = pagingDictionary[.nextKey] as? String {
                    nextPageRequest = request.associatedPageRequest(withNewPath: nextPageLink)
                }
                
                if let previousPageLink = pagingDictionary[.previousKey] as? String {
                    previousPageRequest = request.associatedPageRequest(withNewPath: previousPageLink)
                }
                
                if let firstPageLink = pagingDictionary[.firstKey] as? String {
                    firstPageRequest = request.associatedPageRequest(withNewPath: firstPageLink)
                }
                
                if let lastPageLink = pagingDictionary[.lastKey] as? String {
                    lastPageRequest = request.associatedPageRequest(withNewPath: lastPageLink)
                }
                
                response = Response<ModelType>(model: modelObject,
                                               json: responseDictionary,
                                               isCachedResponse: isCachedResponse,
                                               totalCount: totalCount,
                                               page: currentPage,
                                               itemsPerPage: itemsPerPage,
                                               nextPageRequest: nextPageRequest,
                                               previousPageRequest: previousPageRequest,
                                               firstPageRequest: firstPageRequest,
                                               lastPageRequest: lastPageRequest)
            }
            else {
                response = Response<ModelType>(model: modelObject, json: responseDictionary, isCachedResponse: isCachedResponse)
            }
            
            // To avoid a poisoned cache, explicitly wait until model object parsing is successful to store responseDictionary [RH]
            if request.cacheResponse {
                self.responseCache.setResponse(responseDictionary: responseDictionary, forRequest: request)
            }
            
            completionQueue.async {
                completion(.success(response))
            }
        }
        catch let error {
            self.responseCache.removeResponse(forKey: request.cacheKey)
            
            self.handleTaskFailure(
                for: request,
                urlRequest: urlRequest,
                error: error as NSError,
                completionQueue: completionQueue,
                completion: completion
            )
        }
    }
    
    private func handleTaskFailure<ModelType>(
        for request: Request<ModelType>,
        urlRequest: URLRequest?,
        error: NSError,
        completionQueue: DispatchQueue,
        completion: @escaping ResultCompletion<Response<ModelType>, NSError>.T
    ) {
        guard error.code != NSURLErrorCancelled else {
            // TODO: This error never gets propagated up the chain because we don't call the completion closure here.
            // We need to investigate whether adding the callback here will cause any unforeseen side effects on calling
            // sites before fixing it. [RDPA 10/16/2019]
            return
        }

        self.handleError(error, request: request, urlRequest: urlRequest)
        
        if case .multipleAttempts(let attemptCount, let initialDelay) = request.retryPolicy, attemptCount > 1 {
            var retryRequest = request
            
            retryRequest.retryPolicy = .multipleAttempts(attemptCount: attemptCount - 1, initialDelay: initialDelay * 2)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(initialDelay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
                let _ = self.request(retryRequest, completionQueue: completionQueue, completion: completion)
            }
        }
        
        completionQueue.async {
            completion(.failure(error))
        }
    }
    
    // MARK: - Private error handling
    
    private func handleError<ModelType>(
        _ error: NSError,
        request: Request<ModelType>,
        urlRequest: URLRequest? = nil
    ) {
        if error.isServiceUnavailableError {
            NetworkingNotification.clientDidReceiveServiceUnavailableError.post(object: nil)
        } else if error.isInvalidTokenError {
            NetworkingNotification.clientDidReceiveInvalidTokenError.post(object: self.token(from: urlRequest))
        }
    }
    
    private func token(from urlRequest: URLRequest?) -> String? {
        guard let bearerHeader = urlRequest?.allHTTPHeaderFields?[.authorizationHeader],
            let range = bearerHeader.range(of: String.bearerQuery) else {
            return nil
        }
        var str = bearerHeader
        str.removeSubrange(range)
        return str
    }

}

private extension String {
    // Auth Header constants
    static let bearerQuery = "Bearer "
    static let authorizationHeader = "Authorization"

    // Response Key constants
    static let pagingKey = "paging"
    static let totalKey = "total"
    static let pageKey = "page"
    static let perPageKey = "per_page"
    static let nextKey = "next"
    static let previousKey = "previous"
    static let firstKey = "first"
    static let lastKey = "last"
}
