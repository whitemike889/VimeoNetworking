//
//  Request+Me.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 3/22/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

/// `Request` that returns a `VIMUser`
public typealias UserRequest = Request<VIMUser>

/// `Request` that returns an array of `VIMUser` objects
public typealias UserListRequest = Request<[VIMUser]>

public extension Request
{
    private static var MeUserURI: String { return "/me" }
    private static var FollowingPathFormat: String { return "%@/following" }
    
    /**
     GET the current authenticated `VIMUser`
     
     - returns: a constructed `Request`
     */
    public static func getMeRequest() -> Request
    {
        return self.getUserRequest(userURI: self.MeUserURI)
    }
    
    /**
     GET the list of the users the current user is following
     
     - returns: a constructed `Request`
     */
    public static func getMeFollowingRequest() -> Request
    {
        return self.getUserFollowingRequest(userURI: self.MeUserURI)
    }
    
    /**
     GET a specified `VIMUser`
     
     - parameter userURI: the requested user URI
     
     - returns: a constructed `Request`
     */
    public static func getUserRequest(userURI userURI: String) -> Request
    {
        return Request(path: userURI)
    }
    
    /**
     GET a following list for a user
     
     - parameter userURI: the user's URI
     
     - returns: a constructed `Request`
     */
    public static func getUserFollowingRequest(userURI userURI: String) -> Request
    {
        return Request(path: String(format: self.FollowingPathFormat, userURI))
    }
}