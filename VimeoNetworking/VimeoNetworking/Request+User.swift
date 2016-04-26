//
//  Request+Me.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 3/22/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

public typealias UserRequest = Request<VIMUser>
public typealias UserListRequest = Request<[VIMUser]>

public extension Request
{
    private static var MeUserURI: String { return "/me" }
    private static var FollowingPathFormat: String { return "%@/following" }
    private static var FollowersPathFormat: String { return "%@/followers" }
    
    private static var NameKey: String { return "name" }
    private static var LocationKey: String { return "location" }
    private static var BioKey: String { return "bio" }
    
    public static func getMeRequest() -> Request
    {
        return self.getUserRequest(userURI: self.MeUserURI)
    }
    
    public static func getMeFollowingRequest() -> Request
    {
        return self.getUserFollowingRequest(userURI: self.MeUserURI)
    }
    
    public static func getMeFollowersRequest() -> Request
    {
        return self.getUserFollowersRequest(userURI: self.MeUserURI)
    }
    
    public static func getUserRequest(userURI userURI: String) -> Request
    {
        return Request(path: userURI)
    }
    
    public static func getUserFollowingRequest(userURI userURI: String) -> Request
    {
        return Request(path: String(format: self.FollowingPathFormat, userURI))
    }
    
    public static func getUserFollowersRequest(userURI userURI: String) -> Request
    {
        return Request(path: String(format: self.FollowersPathFormat, userURI))
    }
    
    // MARK: -
    
    public static func patchUser(userURI userURI: String, newName: String?, newLocation: String?, newBio: String?) -> Request
    {
        var parameters = VimeoClient.RequestParameters()
        
        if let newName = newName
        {
            parameters[self.NameKey] = newName
        }
        
        if let newLocation = newLocation
        {
            parameters[self.LocationKey] = newLocation
        }
        
        if let newBio = newBio
        {
            parameters[self.BioKey] = newBio
        }
        
        return Request(method: .PATCH, path: userURI, parameters: parameters)
    }
}