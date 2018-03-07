//
//  ChannelPrivacy.swift
//  Videos
//
//  Created by King, Gavin on 2/6/18.
//  Copyright © 2018 Vimeo. All rights reserved.
//

import Foundation

public struct ChannelPrivacy: Model
{
    public let view: ViewChannelPrivacyLevel?
}

extension ChannelPrivacy
{
    public enum ViewChannelPrivacyLevel: String, Codable
    {
        case anybody
        case moderators
        case users
    }
}
