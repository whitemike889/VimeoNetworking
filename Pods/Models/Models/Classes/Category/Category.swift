//
//  Category.swift
//  Videos
//
//  Created by King, Gavin on 2/6/18.
//  Copyright © 2018 Vimeo. All rights reserved.
//

import Foundation

public struct Category: UniqueModel
{
    // sourcery: jsonKey = resource_key
    public let resourceKey: String
    public let uri: String
    public let name: String?
    public let pictures: Pictures?
    public let metadata: ChannelMetadata?
}
