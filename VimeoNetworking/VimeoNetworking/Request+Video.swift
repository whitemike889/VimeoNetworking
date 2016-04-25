//
//  Request+Video.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 4/5/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

public typealias ToggleRequest = Request<VIMNullResponse>
public typealias VideoRequest = Request<VIMVideo>

public extension Request
{
    public static func getVideoRequest(videoURI videoURI: String) -> Request
    {
        return Request(path: videoURI)
    }
    
    // MARK: - Search
    
    // TODO: search with query [RH] (4/25/16)
    
    // MARK: - Toggle
    
    public static func watchLaterRequest(videoURI videoURI: String, newValue: Bool) -> Request
    {
        return Request(method: newValue ? .PUT : .DELETE, path: "") // TODO:  [RH] (4/25/16)
    }
    
    public static func likeRequest(videoURI videoURI: String, newValue: Bool) -> Request
    {
        return Request(method: newValue ? .PUT : .DELETE, path: "") // TODO:  [RH] (4/25/16)
    }
}