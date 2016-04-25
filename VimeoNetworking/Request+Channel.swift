//
//  Request+Channel.swift
//  VimeoNetworking
//
//  Created by Huebner, Rob on 4/25/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

public typealias ChannelRequest = Request<VIMChannel>

public extension Request
{
    public static func getChannelRequest(channelURI channelURI: String) -> Request
    {
        return Request(path: channelURI)
    }
    
    public static func getChannelSearchRequest(query query: String, extraParameters: [String: String]? = nil) -> Request
    {
        return Request(path: "/channels", parameters: extraParameters)
    }
}