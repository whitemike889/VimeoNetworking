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
    static func getMe() -> Request
    {
        return self.getUser(userURI: "/me")
    }
    
    static func getMeFollowing() -> Request
    {
        return self.getUserFollowing(userURI: "/me")
    }
    
    static func getUser(userURI userURI: String) -> Request
    {
        return Request(path: userURI)
    }
    
    static func getUserFollowing(userURI userURI: String) -> Request
    {
        return Request(path: "\(userURI)/following")
    }
}