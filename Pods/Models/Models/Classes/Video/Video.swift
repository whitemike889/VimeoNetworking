//
//  Video.swift
//  Videos
//
//  Created by King, Gavin on 2/6/18.
//  Copyright © 2018 Vimeo. All rights reserved.
//

import Foundation

public struct Video: UniqueModel
{
    // sourcery: jsonKey = resource_key
    public let resourceKey: String
    public let uri: String
    public let name: String?
    public let description: String?
    public let duration: Int?
    public let width: Int?
    public let height: Int?
    public let privacy: VideoPrivacy?
    public let pictures: Pictures?
    public let stats: Stats?
    public let metadata: VideoMetadata?
    public let user: User?
    public let status: VideoStatus?
    public let badge: VideoBadge?
}

extension Video
{
    public enum VideoStatus: String, Codable
    {
        case available
        case archiveError = "archive_error"
        case archiving
        case done
        case pending
        case ready
        case streaming
        case streamingError = "streaming_error"
        case unavailable
    }
}
