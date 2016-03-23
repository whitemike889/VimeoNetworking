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

private let GrantTypeClientCredentials = "client_credentials"
private let GrantTypeAuthorizationCode = "authorization_code"
private let GrantTypePassword = "password"
private let GrantTypeFacebook = "facebook"

private let AuthenticationPathClientCredentials = "/oauth/authorize/client"
private let AuthenticationPathAccessToken = "oauth/authorize/password"
private let AuthenticationPathUsers = "users"
private let AuthenticationPathFacebookToken = "oauth/authorize/facebook"
private let AuthenticationPathCodeGrant = "oauth/access_token"

typealias AuthenticationRequest = Request<VIMAccountNew>

extension Request
{
    static func clientCredentialsGrantRequest(scopes scopes: [Scope]) -> Request
    {
        let parameters: VimeoClient.RequestParameters = [GrantTypeKey: GrantTypeClientCredentials,
                                                         ScopeKey: Scope.combine(scopes)]
        
        return Request(method: .POST, path: AuthenticationPathClientCredentials, parameters: parameters)
    }
    
    static func codeGrantRequest(code code: String, redirectURI: String) -> Request
    {
        let parameters: VimeoClient.RequestParameters = [GrantTypeKey: GrantTypeAuthorizationCode,
                                                         "code": code,
                                                         "redirect_uri": redirectURI]
        
        return Request(method: .POST, path: AuthenticationPathCodeGrant, parameters: parameters)
    }
    
    static func loginRequest(username username: String, password: String, scopes: [Scope]) -> Request
    {
        let parameters: VimeoClient.RequestParameters = [GrantTypeKey: GrantTypePassword,
                                                         ScopeKey: Scope.combine(scopes),
                                                         "username": username,
                                                         "password": password]
        
        return Request(method: .POST, path: AuthenticationPathAccessToken, parameters: parameters)
    }
    
    static func joinRequest(name name: String, email: String, password: String, scopes: [Scope]) -> Request
    {
        let parameters: VimeoClient.RequestParameters = [ScopeKey: Scope.combine(scopes),
                                                         "display_name": name,
                                                         "email": email,
                                                         "password": password]
        
        return Request(method: .POST, path: AuthenticationPathUsers, parameters: parameters)
    }
    
    static func loginFacebookRequest(facebookToken facebookToken: String, scopes: [Scope]) -> Request
    {
        let parameters: VimeoClient.RequestParameters = [GrantTypeKey: GrantTypeFacebook,
                                                         ScopeKey: Scope.combine(scopes),
                                                         "token": facebookToken]
        
        return Request(method: .POST, path: AuthenticationPathFacebookToken, parameters: parameters)
    }
    
    static func joinFacebookRequest(facebookToken facebookToken: String, scopes: [Scope]) -> Request
    {
        let parameters: VimeoClient.RequestParameters = [ScopeKey: Scope.combine(scopes),
                                                         "token": facebookToken]
        
        return Request(method: .POST, path: AuthenticationPathUsers, parameters: parameters)
    }
}