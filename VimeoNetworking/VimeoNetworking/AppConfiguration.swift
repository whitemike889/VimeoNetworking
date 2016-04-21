//
//  AppConfiguration.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 3/28/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

public struct AppConfiguration
{
    
    let clientKey: String
    let clientSecret: String
    let scopes: [Scope]
    
    // let keychainService: String
    // let keychainAccessGroup: String
    
    let apiVersion: String
    
    public init(clientKey: String,
                clientSecret: String,
                scopes: [Scope],
                apiVersion: String = VimeoDefaultAPIVersionString)
    {
        self.clientKey = clientKey
        self.clientSecret = clientSecret
        self.scopes = scopes
        self.apiVersion = apiVersion
    }
}
