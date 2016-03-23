//
//  Request+Me.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 3/22/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

typealias UserRequest = Request<VIMUser>
typealias UserListRequest = Request<[VIMUser]>

extension Request
{
    static func me() -> Request
    {
        return self.user(userURI: "/me")
    }
    
    static func meFollowing() -> Request
    {
        return self.userFollowing(userURI: "/me")
    }
    
    static func user(userURI userURI: String) -> Request
    {
        return Request(path: userURI)
    }
    
    static func userFollowing(userURI userURI: String) -> Request
    {
        return Request(path: "\(userURI)/following")
    }
}