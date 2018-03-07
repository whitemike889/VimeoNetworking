//
//  Connections.swift
//  Videos
//
//  Created by King, Gavin on 2/5/18.
//  Copyright © 2018 Vimeo. All rights reserved.
//

import Foundation

public struct UserConnections: Model
{
    public let channels: QuantifiedConnection?
    public let followers: QuantifiedConnection?
    public let following: QuantifiedConnection?
    public let likes: QuantifiedConnection?
    // sourcery: jsonKey = moderated_channels
    public let moderatedChannels: QuantifiedConnection?
    public let videos: QuantifiedConnection?
    public let shared: QuantifiedConnection?
}
