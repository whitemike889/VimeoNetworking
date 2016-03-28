//
//  AuthenticationController.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 3/21/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

final class AuthenticationController
{
    private static let ErrorDomain = "AuthenticationControllerErrorDomain"
    
    private static let ErrorAuthToken = 1004 // TODO: Make this an enum to ensure uniqueness [RH] (3/23/16)
    
    typealias AuthenticationCompletion = ResultCompletion<VIMAccountNew>.T
    
    let configuration: AppConfiguration
    let client: VimeoClient
    
    let accountStore = AccountStore()
    
    init(configuration: AppConfiguration, client: VimeoClient)
    {
        self.configuration = configuration
        self.client = client
    }
    
    // MARK: - 
    
    /// This method will:
    /// 1. check for a user authenticated account, then 
    /// 2. check for a client credentials authenticated account, then finally
    /// 3. attempt to authenticate with client credentials
    func initialAuthentication(completion: AuthenticationCompletion)
    {
        let userAccount: VIMAccountNew?
        let clientCredentialsAccount: VIMAccountNew?
        
        // check saved accounts
        do
        {
            userAccount = try self.accountStore.loadAccount(.User)
            clientCredentialsAccount = try self.accountStore.loadAccount(.ClientCredentials)
            
            if let account = userAccount ?? clientCredentialsAccount
            {
                try self.setupRequestSerializer(account: account)
                
                completion(result: .Success(result: account))
                
                return
            }
        }
        catch let error
        {
            completion(result: .Failure(error: error as NSError))
        }
        
        // if necessary, make a request for client credentials
        
        self.clientCredentialsGrant(completion)
    }
    
    // MARK: -
    
    func clientCredentialsGrant(completion: AuthenticationCompletion)
    {
        let request = AuthenticationRequest.postClientCredentialsGrant(scopes: self.configuration.scopes)
        
        self.authenticate(request: request, completion: completion)
    }
    
    func codeGrant()
    {
        // TODO:  [RH] (3/23/16)
    }
    
    func login(username username: String, password: String, completion: AuthenticationCompletion)
    {
        let request = AuthenticationRequest.postLogin(username: username, password: password, scopes: self.configuration.scopes)
        
        self.authenticate(request: request, completion: completion)
    }
    
    func join(name name: String, email: String, password: String, completion: AuthenticationCompletion)
    {
        let request = AuthenticationRequest.postJoin(name: name, email: email, password: password, scopes: self.configuration.scopes)
        
        self.authenticate(request: request, completion: completion)
    }
    
    func facebookLogin()
    {
        // TODO:  [RH] (3/23/16)
    }
    
    func facebookJoin()
    {
        // TODO:  [RH] (3/23/16)
    }
    
    private func authenticate(request request: AuthenticationRequest, completion: AuthenticationCompletion)
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
        
        do
        {
            try self.setupRequestSerializer(account: account)
            
            let accountType: AccountStore.AccountType = (account.user != nil) ? .User : .ClientCredentials
            try self.accountStore.saveAccount(account, type: accountType)
        }
        catch let error
        {
            return .Failure(error: error as NSError)
        }
        
        return result
    }
    
    private func setupRequestSerializer(account account: VIMAccountNew) throws
    {
        guard let authToken = account.accessToken
            else
        {
            let errorDescription = "AuthenticationController did not recieve an access token with account response"
            
            assertionFailure(errorDescription)
            
            let error = NSError(domain: self.dynamicType.ErrorDomain, code: self.dynamicType.ErrorAuthToken, userInfo: [NSLocalizedDescriptionKey: errorDescription])
            
            throw error
        }
        
        // TODO: can we do this better? [RH] (3/28/16)
        // like maybe notifications? delegate? account update block?
        self.client.sessionManager.requestSerializer = VimeoRequestSerializer(authTokenBlock: { authToken })
    }
}