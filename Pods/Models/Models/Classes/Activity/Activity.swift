//
//  Activity.swift
//  Videos
//
//  Created by King, Gavin on 2/6/18.
//  Copyright © 2018 Vimeo. All rights reserved.
//

import Foundation

public struct Activity: Model
{
    public let clip: Video?
    public let type: ActivityType?
    public let time: Date?
    public let user: User?
}

extension Activity
{
    public enum ActivityType: String, Codable
    {
        case addComment = "add_comment"
        case addCommentBlog = "add_comment_blog"
        case addCommentClient = "add_comment_client"
        case addCommentForum = "add_comment_forum"
        case addCommentOnDemand = "add_comment_ondemand"
        case addHelpCommentForum = "add_help_comment_forum"
        case addPortfolio = "add_portfolio"
        case addTags = "add_tags"
        case albumClip = "album_clip"
        case albumCreate = "album_create"
        case channelClip = "channel_clip"
        case channelCreate = "channel_create"
        case channelSubscribe = "channel_subscribe"
        case followUser = "follow_user"
        case groupClip = "group_clip"
        case groupClipComment = "group_clip_comment"
        case groupCreate = "group_create"
        case groupJoin = "group_join"
        case like
        case onDemandPublish = "ondemand_publish"
        case portfolioClip = "portfolio_clip"
        case tipClip = "tip_clip"
        case upload
        case category
    }
}
