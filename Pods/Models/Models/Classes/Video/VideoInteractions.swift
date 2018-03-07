//
//  VideoInteractions.swift
//  Videos
//
//  Created by King, Gavin on 2/6/18.
//  Copyright © 2018 Vimeo. All rights reserved.
//

import Foundation

public struct VideoInteractions: Model
{
    // sourcery: jsonKey = watchlater
    public let watchLater: MembershipInteraction?
    public let like: MembershipInteraction?
    public let report: VideoReportInteraction?
}
