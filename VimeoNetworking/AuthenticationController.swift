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
    static let ErrorDomain = "AuthenticationControllerErrorDomain"
    
    static let ErrorAuthToken = 1004 // TODO: Make this an enum to ensure uniqueness [RH] (3/23/16)
    static let ErrorCodeGrant = 1005
    static let ErrorCodeGrantState = 1006
    
    typealias AuthenticationCompletion = ResultCompletion<VIMAccountNew>.T
    
    /// State is tracked for the code grant request/response cycle, to avoid 
    static let state = NSProcessInfo.processInfo().globallyUniqueString
    
    let configuration: AppConfiguration
    let client: VimeoClient
    
    let accountStore = AccountStore()
    
    init(configuration: AppConfiguration, client: VimeoClient)
    {
        self.configuration = configuration
        self.client = client
    }
    
    // MARK: - Launch
    
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
    
    // MARK: - Public Authentication
    
    func clientCredentialsGrant(completion: AuthenticationCompletion)
    {
        let request = AuthenticationRequest.postClientCredentialsGrant(scopes: self.configuration.scopes)
        
        self.authenticate(request: request, completion: completion)
    }
    
    var codeGrantRedirectURI: String
    {
        let scheme = "vimeo\(self.configuration.clientKey)"
        let path = "auth"
        let URI = "\(scheme)://\(path)"
        
        return URI
    }
    
    func codeGrantAuthorizationURL() -> NSURL
    {
        let parameters = ["response_type": "code",
                          "client_id": self.configuration.clientKey,
                          "redirect_uri": self.codeGrantRedirectURI,
                          "scope": Scope.combine(self.configuration.scopes),
                          "state": self.dynamicType.state]
        
        var error: NSError?
        let urlRequest = self.client.sessionManager.requestSerializer.requestWithMethod("GET", URLString: "", parameters: parameters, error: &error)
        guard let url = urlRequest.URL where error == nil
        else
        {
            fatalError("Could not make code grant auth URL")
        }
        
        return url
        
    }
    
    func codeGrant(responseURL responseURL: NSURL, completion: AuthenticationCompletion)
    {
        guard let queryString = responseURL.query,
            let parameters = self.parametersFromQueryString(queryString),
            let code = parameters["code"],
            let state = parameters["state"]
        else
        {
            let errorDescription = "Could not retrieve parameters from code grant response"
            
            assertionFailure(errorDescription)
            
            let error = NSError(domain: self.dynamicType.ErrorDomain, code: self.dynamicType.ErrorCodeGrant, userInfo: [NSLocalizedDescriptionKey: errorDescription])
            
            completion(result: .Failure(error: error))
            
            return
        }
        
        if state != self.dynamicType.state
        {
            let errorDescription = "Code grant returned state did not match existing state"
            
            assertionFailure(errorDescription)
            
            let error = NSError(domain: self.dynamicType.ErrorDomain, code: self.dynamicType.ErrorCodeGrantState, userInfo: [NSLocalizedDescriptionKey: errorDescription])
            
            completion(result: .Failure(error: error))
            
            return
        }
        
        let request = AuthenticationRequest.postCodeGrant(code: code, redirectURI: self.codeGrantRedirectURI)
        
        self.authenticate(request: request, completion: completion)
    }
    
    // MARK: - Private Authentication
    
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
    
    func facebookLogin(facebookToken facebookToken: String, completion: AuthenticationCompletion)
    {
        let request = AuthenticationRequest.postLoginFacebook(facebookToken: facebookToken, scopes: self.configuration.scopes)
        
        self.authenticate(request: request, completion: completion)
    }
    
    func facebookJoin(facebookToken facebookToken: String, completion: AuthenticationCompletion)
    {
        let request = AuthenticationRequest.postJoinFacebook(facebookToken: facebookToken, scopes: self.configuration.scopes)
        
        self.authenticate(request: request, completion: completion)
    }
    
    // MARK: - Private
    
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
    
    // MARK: - Private: Utility
    
    private func parametersFromQueryString(queryString: String) -> [String: String]?
    {
        var parameters: [String: String] = [:]
        
        let scanner = NSScanner(string: queryString)
        while !scanner.atEnd
        {
            var name: NSString?
            let equals = "="
            scanner.scanUpToString(equals, intoString: &name)
            scanner.scanString(equals, intoString: nil)
            
            var value: NSString?
            let ampersand = "&"
            scanner.scanUpToString(ampersand, intoString: &value)
            scanner.scanString(ampersand, intoString: nil)
            
            if let name = name?.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding),
                let value = value?.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
            {
                parameters[name] = value
            }
        }
        
        return parameters.count > 0 ? parameters : nil
    }
}