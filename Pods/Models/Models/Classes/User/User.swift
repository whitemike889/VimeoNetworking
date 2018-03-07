//
//  User.swift
//  Videos
//
//  Created by King, Gavin on 1/26/18.
//  Copyright © 2018 Vimeo. All rights reserved.
//

public struct User: UniqueModel
{
    // sourcery: jsonKey = resource_key
    public let resourceKey: String
    public let uri: String
    public let name: String?
    public let location: String?
    public let bio: String?
    public let account: AccountType?
    public let pictures: Pictures?
    public let metadata: UserMetadata?
    public let badge: UserBadge?
    public let preferences: Preferences?
    // sourcery: jsonKey = content_filter
    public let contentFilter: [ContentType]?
    // sourcery: jsonKey = upload_quota
    public let uploadQuota: UploadQuota?
    public let emails: [Email]?
}

extension User
{
    public enum AccountType: String, Codable
    {
        case basic
        case business
        case liveBusiness = "live_business"
        case livePro = "live_pro"
        case plus
        case pro
        case proUnlimited = "pro_unlimited"
    }
    
    public enum ContentType: String, Codable
    {
        case drugs
        case language
        case nudity
        case safe
        case unrated
        case violence
    }
}
