//
//  AppConfiguration.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 3/28/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

public let KeychainServiceVimeo = "Vimeo"
public let KeychainServiceCameo = "Cameo"

public struct AppConfiguration
{
    let clientIdentifier: String
    let clientSecret: String
    let scopes: [Scope]
    
    let keychainService: String
    let keychainAccessGroup: String?
    
    let apiVersion: String
    
    public init(clientKey: String,
                clientSecret: String,
                scopes: [Scope],
                keychainService: String = KeychainServiceVimeo,
                keychainAccessGroup: String? = nil,
                apiVersion: String = VimeoDefaultAPIVersionString)
    {
        self.clientIdentifier = clientKey
        self.clientSecret = clientSecret
        self.scopes = scopes
        self.keychainService = keychainService
        self.keychainAccessGroup = keychainAccessGroup
        self.apiVersion = apiVersion
    }
}
