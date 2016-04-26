//
//  AuthenticationController.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 3/21/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

final public class AuthenticationController
{
    static let ErrorDomain = "AuthenticationControllerErrorDomain"
    
    private static let ResponseTypeKey = "response_type"
    private static let CodeKey = "code"
    private static let ClientIDKey = "client_id"
    private static let RedirectURIKey = "redirect_uri"
    private static let ScopeKey = "scope"
    private static let StateKey = "state"
    
    private static let CodeGrantAuthorizationPath = "oauth/authorize"
    
    public typealias AuthenticationCompletion = ResultCompletion<VIMAccount>.T
    
    /// State is tracked for the code grant request/response cycle, to avoid interception
    static let state = NSProcessInfo.processInfo().globallyUniqueString
    
    let configuration: AppConfiguration
    let client: VimeoClient
    
    private let accountStore = AccountStore()
    
    public init(client: VimeoClient)
    {
        self.configuration = client.configuration
        self.client = client
    }
    
    public init(configuration: AppConfiguration, client: VimeoClient)
    {
        self.configuration = configuration
        self.client = client
    }
    
    // MARK: - Saved Accounts
    
    public func loadSavedAccount() throws -> VIMAccount?
    {
        var loadedAccount = try self.accountStore.loadAccount(.User)
        
        if loadedAccount == nil
        {
            loadedAccount = try self.accountStore.loadAccount(.ClientCredentials)
        }
        
        if let loadedAccount = loadedAccount
        {
            try self.authenticateClient(account: loadedAccount)
            
            print("loaded account \(loadedAccount)")
            
            // TODO: refresh user [RH] (4/25/16)
            
            // TODO: after refreshing user, send notification [RH] (4/25/16)
        }
        else
        {
            print("no account loaded")
        }
        
        return loadedAccount
    }
    
    // MARK: - Public Authentication
    
    public func clientCredentialsGrant(completion: AuthenticationCompletion)
    {
        let request = AuthenticationRequest.postClientCredentialsGrantRequest(scopes: self.configuration.scopes)
        
        self.authenticate(request: request, completion: completion)
    }
    
    public var codeGrantRedirectURI: String
    {
        let scheme = "vimeo\(self.configuration.clientKey)"
        let path = "auth"
        let URI = "\(scheme)://\(path)"
        
        return URI
    }
    
    public func codeGrantAuthorizationURL() -> NSURL
    {
        let parameters = [self.dynamicType.ResponseTypeKey: self.dynamicType.CodeKey,
                          self.dynamicType.ClientIDKey: self.configuration.clientKey,
                          self.dynamicType.RedirectURIKey: self.codeGrantRedirectURI,
                          self.dynamicType.ScopeKey: Scope.combine(self.configuration.scopes),
                          self.dynamicType.StateKey: self.dynamicType.state]
        
        guard let urlString = VimeoBaseURLString?.URLByAppendingPathComponent(self.dynamicType.CodeGrantAuthorizationPath).absoluteString
        else
        {
            fatalError("Could not make code grant auth URL")
        }
        
        var error: NSError?
        let urlRequest = VimeoRequestSerializer(appConfiguration: self.configuration).requestWithMethod(VimeoClient.Method.GET.rawValue, URLString: urlString, parameters: parameters, error: &error)
        
        guard let url = urlRequest.URL where error == nil
        else
        {
            fatalError("Could not make code grant auth URL")
        }
        
        return url
    }
    
    public func codeGrant(responseURL responseURL: NSURL, completion: AuthenticationCompletion)
    {
        guard let queryString = responseURL.query,
            let parameters = queryString.parametersFromQueryString(),
            let code = parameters[self.dynamicType.CodeKey],
            let state = parameters[self.dynamicType.StateKey]
        else
        {
            let errorDescription = "Could not retrieve parameters from code grant response"
            
            assertionFailure(errorDescription)
            
            let error = NSError(domain: self.dynamicType.ErrorDomain, code: LocalErrorCode.CodeGrant.rawValue, userInfo: [NSLocalizedDescriptionKey: errorDescription])
            
            completion(result: .Failure(error: error))
            
            return
        }
        
        if state != self.dynamicType.state
        {
            let errorDescription = "Code grant returned state did not match existing state"
            
            assertionFailure(errorDescription)
            
            let error = NSError(domain: self.dynamicType.ErrorDomain, code: LocalErrorCode.CodeGrantState.rawValue, userInfo: [NSLocalizedDescriptionKey: errorDescription])
            
            completion(result: .Failure(error: error))
            
            return
        }
        
        let request = AuthenticationRequest.postCodeGrantRequest(code: code, redirectURI: self.codeGrantRedirectURI)
        
        self.authenticate(request: request, completion: completion)
    }
    
    // MARK: - Private Authentication
    
    public func login(email email: String, password: String, completion: AuthenticationCompletion)
    {
        let request = AuthenticationRequest.postLoginRequest(email: email, password: password, scopes: self.configuration.scopes)
        
        self.authenticate(request: request, completion: completion)
    }
    
    public func join(name name: String, email: String, password: String, completion: AuthenticationCompletion)
    {
        let request = AuthenticationRequest.postJoinRequest(name: name, email: email, password: password, scopes: self.configuration.scopes)
        
        self.authenticate(request: request, completion: completion)
    }
    
    public func facebookLogin(facebookToken facebookToken: String, completion: AuthenticationCompletion)
    {
        let request = AuthenticationRequest.postLoginFacebookRequest(facebookToken: facebookToken, scopes: self.configuration.scopes)
        
        self.authenticate(request: request, completion: completion)
    }
    
    public func facebookJoin(facebookToken facebookToken: String, completion: AuthenticationCompletion)
    {
        let request = AuthenticationRequest.postJoinFacebookRequest(facebookToken: facebookToken, scopes: self.configuration.scopes)
        
        self.authenticate(request: request, completion: completion)
    }
    
    // MARK: - Log out
    
    public func logOut() throws
    {
        guard self.client.isAuthenticatedWithUser == true
        else
        {
            return
        }
        
        self.client.authenticatedAccount = nil
        
        try self.accountStore.removeAccount(.User)
        
        let deleteTokensRequest = Request<VIMNullResponse>.deleteTokensRequest()
        self.client.request(deleteTokensRequest) { (result) in
            switch result
            {
            case .Success:
                break
            case .Failure(let error):
                print("could not delete tokens: \(error)")
            }
        }
    }
    
    // MARK: - Private
    
    private func authenticate(request request: AuthenticationRequest, completion: AuthenticationCompletion)
    {
        self.client.request(request) { result in
            
            let handledResult = self.handleAuthenticationResult(result)
            
            completion(result: handledResult)
        }
    }
    
    private func handleAuthenticationResult(result: Result<Response<VIMAccount>>) -> Result<VIMAccount>
    {
        guard case .Success(let accountResponse) = result
        else
        {
            let resultError: NSError
            if case .Failure(let error) = result
            {
                resultError = error
            }
            else
            {
                let errorDescription = "Authentication result malformed"
                
                assertionFailure(errorDescription)
                
                resultError = NSError(domain: self.dynamicType.ErrorDomain, code: LocalErrorCode.NoResponse.rawValue, userInfo: [NSLocalizedDescriptionKey: errorDescription])
            }
            
            return .Failure(error: resultError)
        }
        
        let account = accountResponse.model
        
        if let userJSON = accountResponse.json["user"] as? VimeoClient.ResponseDictionary
        {
            account.userJSON = userJSON
        }
        
        do
        {
            try self.authenticateClient(account: account)
            
            let accountType: AccountStore.AccountType = (account.user != nil) ? .User : .ClientCredentials
            
            try self.accountStore.saveAccount(account, type: accountType)
        }
        catch let error
        {
            return .Failure(error: error as NSError)
        }
        
        return .Success(result: account)
    }
    
    private func authenticateClient(account account: VIMAccount) throws
    {
        guard account.accessToken != nil
        else
        {
            let errorDescription = "AuthenticationController did not recieve an access token with account response"
            
            assertionFailure(errorDescription)
            
            let error = NSError(domain: self.dynamicType.ErrorDomain, code: LocalErrorCode.AuthToken.rawValue, userInfo: [NSLocalizedDescriptionKey: errorDescription])
            
            throw error
        }
        
        self.client.authenticatedAccount = account
    }
}