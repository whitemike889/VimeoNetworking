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

public extension Request
{
    private static var MeUserURI: String { return "/me" }
    private static var FollowingPathFormat: String { return "%@/following" }
    
    static func getMeRequest() -> Request
    {
        return self.getUserRequest(userURI: self.MeUserURI)
    }
    
    static func getMeFollowingRequest() -> Request
    {
        return self.getUserFollowingRequest(userURI: self.MeUserURI)
    }
    
    static func getUserRequest(userURI userURI: String) -> Request
    {
        return Request(path: userURI)
    }
    
    static func getUserFollowingRequest(userURI userURI: String) -> Request
    {
        return Request(path: String(format: self.FollowingPathFormat, userURI))
    }
}