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

private let ClientCredentialsGrantTypeValue = "client_credentials"

private let ClientCredentialsPath = "/oauth/authorize/client"

typealias AuthenticationRequest = Request<VIMAccountNew>

extension Request
{
    static func clientCredentialsGrantRequest(scopes scopes: [Scope]) -> Request
    {
        let parameters: VimeoClient.RequestParameters = [GrantTypeKey: ClientCredentialsGrantTypeValue,
                                                         ScopeKey: Scope.combine(scopes)]
        
        return Request(method: .POST, path: ClientCredentialsPath, parameters: parameters)
    }
}