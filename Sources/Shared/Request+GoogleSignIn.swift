//
//  Request+GoogleSignIn.swift
//  Vimeo
//
//  Created by Lehrer, Nicole on 8/16/17.
//  Copyright © 2017 Vimeo. All rights reserved.
//

private enum Constants {
    static let GrantTypeGoogle = "google"
    static let AuthenticationPathGoogleToken = "oauth/authorize/google"
}

extension Request where ModelType: VIMAccount {
    /// Constructs a `Request` for logging in with Google. For internal use only.
    ///
    /// - Parameters:
    ///   - googleToken: The `idToken` returned by the GoogleSignIn SDK.
    ///   - scopes: An array of `Scope` values representing permissions for app requests.
    /// - Returns: A new `Request`.
    public static func logInWithGoogleRequest(withToken googleToken: String, scopes: [Scope]) -> Request {
        let parameters = [
            GrantTypeKey: Constants.GrantTypeGoogle,
            ScopeKey: Scope.combine(scopes),
            TokenKey: googleToken
        ]

        return Request(method: .POST, path: Constants.AuthenticationPathGoogleToken, parameters: parameters)
    }

    /// Constructs a `Request` for joining with Google. For internal use only.
    ///
    /// - Parameters:
    ///   - googleToken: The `idToken` returned by the GoogleSignIn SDK.
    ///   - marketingOptIn: Indicates whether a user has opted to receive marketing material.
    ///   - scopes: An array of `Scope` values representing permissions for app requests.
    /// - Returns: A new `Request`.
    public static func joinWithGoogleRequest(withToken googleToken: String, marketingOptIn: String, scopes: [Scope])
        -> Request
    {
        let parameters = [
            ScopeKey: Scope.combine(scopes),
            TokenKey: googleToken,
            MarketingOptIn: marketingOptIn
        ]

        return Request(method: .POST, path: AuthenticationPathUsers, parameters: parameters)
    }
}
