//
//  AuthenticationController.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 3/21/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

struct AuthenticationConfiguration
{
    let clientKey: String
    let clientSecret: String
    let scopes: [Scope]
}

class AuthenticationController
{
    private static let ClientCredentialsPath = "oauth/authorize/client"
    private static let ClientCredentialsGrantType = "client_credentials"
    
    private static let ErrorDomain = "AuthenticationControllerErrorDomain"
    
    private static let ErrorAuthToken = 1004 // TODO: Make this an enum to ensure uniqueness [RH] (3/23/16)
    
    typealias AuthenticationCompletion = ResultCompletion<VIMAccountNew>.T
    
    let configuration: AuthenticationConfiguration
    let client: VimeoClient
    
    init(configuration: AuthenticationConfiguration, client: VimeoClient)
    {
        self.configuration = configuration
        self.client = client
    }
    
    func authenticateWithClientCredentialsGrant(completion: AuthenticationCompletion)
    {
        let request = AuthenticationRequest.clientCredentialsGrantRequest(scopes: self.configuration.scopes)
        
        self.authenticate(request: request, completion: completion)
    }
    
    private func authenticate(request request: Request<VIMAccountNew>, completion: AuthenticationCompletion)
    {
        self.client.request(request) { result in
            
            let handledResult = self.handleAuthenticationResult(result)
            
            completion(result: handledResult)
        }
    }
    
    private func handleAuthenticationResult(result: Result<VIMAccountNew>) -> Result<VIMAccountNew>
    {
        guard case .Success(let account) = result
        else
        {
            // An error was returned from the API, there's nothing to handle [RH]
            
            return result
        }
        
        guard let authToken = account.accessToken
        else
        {
            let errorDescription = "AuthenticationController did not recieve an access token with account response"
            
            assertionFailure(errorDescription)
            
            let error = NSError(domain: self.dynamicType.ErrorDomain, code: self.dynamicType.ErrorAuthToken, userInfo: [NSLocalizedDescriptionKey: errorDescription])
            
            return .Failure(error: error)
        }
        
        self.client.sessionManager.requestSerializer = VimeoRequestSerializer(authTokenBlock: { authToken })
        
        // TODO: Save account [RH] (3/23/16)
//        try AccountStore.saveAccount(account)
//        catch let error
//        {
//            return .Failure(error: error)
//        }
        
        return result
    }
}