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
    private static var QueryKey: String { return "query" }
    
    private static var ChannelsPath: String { return "/channels" }
    
    public static func getChannelRequest(channelURI channelURI: String) -> Request
    {
        return Request(path: channelURI)
    }
    
    public static func queryChannels(query query: String, refinements: VimeoClient.RequestParameters? = nil) -> Request
    {
        var parameters = refinements ?? [:]
        
        parameters[self.QueryKey] = query
        
        return Request(path: self.ChannelsPath, parameters: parameters)
    }
}