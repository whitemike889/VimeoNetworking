//
//  VimeoClient+SharedInstance.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 5/13/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

/// Extend app configuration to provide a default configuration
private extension AppConfiguration
{
    /// The default configuration to use for this application, populate your client key, secret, and scopes
    private static let defaultConfiguration = AppConfiguration(clientKey: "YOUR_CLIENT_KEY_HERE", clientSecret: "YOUR_CLIENT_SECRET_HERE", scopes: [])
}

/// Extend vimeo client to provide a default client
extension VimeoClient
{
    /// The default client this application should use for networking, must be authenticated by an `AuthenticationController` before sending requests
    static let defaultClient = VimeoClient(appConfiguration: AppConfiguration.defaultConfiguration)
}
