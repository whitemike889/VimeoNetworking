//
//  Channel.swift
//  Videos
//
//  Created by King, Gavin on 2/6/18.
//  Copyright © 2018 Vimeo. All rights reserved.
//

import Foundation

public struct Channel: UniqueModel
{
    // sourcery: jsonKey = resource_key
    public let resourceKey: String
    public let uri: String
    public let name: String?
    public let description: String?
    public let privacy: ChannelPrivacy?
    public let pictures: Pictures?
    public let metadata: ChannelMetadata?
    public let user: User?
}
