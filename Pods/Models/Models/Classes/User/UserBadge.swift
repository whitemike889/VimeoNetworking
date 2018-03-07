//
//  UserBadge.swift
//  Videos
//
//  Created by King, Gavin on 2/5/18.
//  Copyright © 2018 Vimeo. All rights reserved.
//

import Foundation

public struct UserBadge: Model
{
    public let type: UserBadgeType?
    public let text: String?
}

extension UserBadge
{
    public enum UserBadgeType: String, Codable
    {
        case alum
        case business
        case curation
        case plus
        case potus
        case pro
        case sponsor
        case staff
        case support
    }
}
