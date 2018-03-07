//
//  VideoPrivacy.swift
//  Videos
//
//  Created by King, Gavin on 2/5/18.
//  Copyright © 2018 Vimeo. All rights reserved.
//

import Foundation

public struct VideoPrivacy: Model
{
    public let view: ViewVideoPrivacyLevel?
    public let comments: CommentsVideoPrivacyLevel?
    public let embed: EmbedVideoPrivacyLevel?
    public let download: Bool?
    public let add: Bool?
}

extension VideoPrivacy
{
    public enum ViewVideoPrivacyLevel: String, Codable
    {
        case anybody
        case contacts
        case nobody
        case password
        case users
    }
    
    public enum CommentsVideoPrivacyLevel: String, Codable
    {
        case anybody
        case contacts
        case nobody
    }
    
    public enum EmbedVideoPrivacyLevel: String, Codable
    {
        case `private`
        case `public`
    }
}
