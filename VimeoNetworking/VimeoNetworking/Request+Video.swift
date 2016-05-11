//
//  Request+Video.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 4/5/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

/// `Request` that returns no expected response (success is a simple 200 OK response)
public typealias ToggleRequest = Request<VIMNullResponse>

public extension Request
{
    /**
     Generate a video watch later request
     
     - parameter videoURI: the uri of the video to watch later
     
     - returns: a constructed `Request`
     */
    public static func watchLaterRequest(videoURI videoURI: String) -> Request
    {
        return Request(method: .PUT, path: "/users/10895030/likes/7235817")
    }
}