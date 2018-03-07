//
//  VideoReportInteraction.swift
//  Videos
//
//  Created by King, Gavin on 2/6/18.
//  Copyright © 2018 Vimeo. All rights reserved.
//

import Foundation

public struct VideoReportInteraction: Model
{
    public let uri: String?
    public let reason: [Reason]?
}

extension VideoReportInteraction
{
    public enum Reason: String, Codable
    {
        case pornographic
        case harassment
        case advertisement
        case ripoff
        case incorrectRating = "incorrect rating"
        case spam
    }
}
