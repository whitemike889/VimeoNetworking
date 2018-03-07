//
//  VideoConnections.swift
//  Videos
//
//  Created by King, Gavin on 2/6/18.
//  Copyright © 2018 Vimeo. All rights reserved.
//

import Foundation

public struct VideoConnections: Model
{
    public let comments: QuantifiedConnection?
    public let likes: QuantifiedConnection?
    public let related: Connection?
    public let recommendations: Connection?
}
