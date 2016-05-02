//
//  Request+Authentication.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 3/23/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

private let GrantTypeKey = "grant_type"
private let ScopeKey = "scope"
private let CodeKey = "code"
private let RedirectURIKey = "redirect_uri"
private let UsernameKey = "username"
private let PasswordKey = "password"
private let DisplayNameKey = "display_name"
private let EmailKey = "email"
private let TokenKey = "token"
private let PinCodeKey = "user_code"
private let DeviceCodeKey = "device_code"

private let GrantTypeClientCredentials = "client_credentials"
private let GrantTypeAuthorizationCode = "authorization_code"
private let GrantTypePassword = "password"
private let GrantTypeFacebook = "facebook"
private let GrantTypePinCode = "device_grant"

private let AuthenticationPathClientCredentials = "oauth/authorize/client"
private let AuthenticationPathAccessToken = "oauth/authorize/password"
private let AuthenticationPathUsers = "users"
private let AuthenticationPathFacebookToken = "oauth/authorize/facebook"
private let AuthenticationPathCodeGrant = "oauth/access_token"
private let AuthenticationPathPinCode = "oauth/device"
private let AuthenticationPathPinCodeAuthorize = "oauth/device/authorize"

// MARK: -

private let AuthenticationPathTokens = "/tokens"

public typealias AuthenticationRequest = Request<VIMAccount>

public extension Request where ModelType: VIMAccount
{
    public static func clientCredentialsGrantRequest(scopes scopes: [Scope]) -> Request
    {
        let parameters: VimeoClient.RequestParameters = [GrantTypeKey: GrantTypeClientCredentials,
                                                         ScopeKey: Scope.combine(scopes)]
        
        return Request(method: .POST, path: AuthenticationPathClientCredentials, parameters: parameters, cacheFetchPolicy: .NetworkOnly, shouldCacheResponse: false)
    }
    
    public static func codeGrantRequest(code code: String, redirectURI: String) -> Request
    {
        let parameters: VimeoClient.RequestParameters = [GrantTypeKey: GrantTypeAuthorizationCode,
                                                         CodeKey: code,
                                                         RedirectURIKey: redirectURI]
        
        return Request(method: .POST, path: AuthenticationPathCodeGrant, parameters: parameters, cacheFetchPolicy: .NetworkOnly, shouldCacheResponse: false)
    }
    
    public static func loginRequest(email email: String, password: String, scopes: [Scope]) -> Request
    {
        let parameters: VimeoClient.RequestParameters = [GrantTypeKey: GrantTypePassword,
                                                         ScopeKey: Scope.combine(scopes),
                                                         UsernameKey: email,
                                                         PasswordKey: password]
        
        return Request(method: .POST, path: AuthenticationPathAccessToken, parameters: parameters, cacheFetchPolicy: .NetworkOnly, shouldCacheResponse: false)
    }
    
    public static func joinRequest(name name: String, email: String, password: String, scopes: [Scope]) -> Request
    {
        let parameters: VimeoClient.RequestParameters = [ScopeKey: Scope.combine(scopes),
                                                         DisplayNameKey: name,
                                                         EmailKey: email,
                                                         PasswordKey: password]
        
        return Request(method: .POST, path: AuthenticationPathUsers, parameters: parameters, cacheFetchPolicy: .NetworkOnly, shouldCacheResponse: false)
    }
    
    public static func loginFacebookRequest(facebookToken facebookToken: String, scopes: [Scope]) -> Request
    {
        let parameters: VimeoClient.RequestParameters = [GrantTypeKey: GrantTypeFacebook,
                                                         ScopeKey: Scope.combine(scopes),
                                                         TokenKey: facebookToken]
        
        return Request(method: .POST, path: AuthenticationPathFacebookToken, parameters: parameters, cacheFetchPolicy: .NetworkOnly, shouldCacheResponse: false)
    }
    
    public static func joinFacebookRequest(facebookToken facebookToken: String, scopes: [Scope]) -> Request
    {
        let parameters: VimeoClient.RequestParameters = [ScopeKey: Scope.combine(scopes),
                                                         TokenKey: facebookToken]
        
        return Request(method: .POST, path: AuthenticationPathUsers, parameters: parameters, cacheFetchPolicy: .NetworkOnly, shouldCacheResponse: false)
    }
    
    public static func authorizePinCodeRequest(userCode userCode: String, deviceCode: String) -> Request
    {
        let parameters: VimeoClient.RequestParameters = [PinCodeKey: userCode,
                                                         DeviceCodeKey: deviceCode]
        
        return Request(method: .POST, path: AuthenticationPathPinCodeAuthorize, parameters: parameters, cacheFetchPolicy: .NetworkOnly, shouldCacheResponse: false)
    }
}

extension Request where ModelType: VIMNullResponse
{
    public static func deleteTokensRequest() -> Request
    {
        return Request(method: .DELETE, path: AuthenticationPathTokens, retryPolicy: .TryThreeTimes)
    }
}

// MARK: -

public typealias PinCodeRequest = Request<PinCodeInfo>

public class PinCodeInfo: VIMModelObject
{
    dynamic public var deviceCode: String?
    dynamic public var userCode: String?
    dynamic public var authorizeLink: String?
    dynamic public var activateLink: String?
    
    // These are non-optional Ints with -1 invalid sentinel values because 
    // an optional Int can't be represented in Objective-C and can't be marked 
    // dynamic, which leads to it not getting parsed by VIMObjectMapper [RH]
    dynamic public var expiresIn: Int = -1
    dynamic public var interval: Int = -1
}

public extension Request where ModelType: PinCodeInfo
{
    public static func getPinCodeRequest(scopes scopes: [Scope]) -> Request
    {
        let parameters: VimeoClient.RequestParameters = [GrantTypeKey: GrantTypePinCode,
                                                         ScopeKey: Scope.combine(scopes)]
        
        return Request(method: .POST, path: AuthenticationPathPinCode, parameters: parameters, cacheFetchPolicy: .NetworkOnly, shouldCacheResponse: false)
    }
}