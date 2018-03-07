//
//  UserReportInteraction.swift
//  Videos
//
//  Created by King, Gavin on 2/5/18.
//  Copyright © 2018 Vimeo. All rights reserved.
//

import Foundation

public struct UserReportInteraction: Model
{
    public let uri: String?
    public let reason: [Reason]?
}

extension UserReportInteraction
{
    public enum Reason: String, Codable
    {
        case inappropriateAvatar = "inappropriate avatar"
        case spammy
        case badVideos = "bad videos"
        case creepy
        case notPlayingNice = "not playing nice"
        case impersonation
    }
}
