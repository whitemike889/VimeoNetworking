//
//  VideoBadge.swift
//  Videos
//
//  Created by King, Gavin on 2/6/18.
//  Copyright © 2018 Vimeo. All rights reserved.
//

import Foundation

public struct VideoBadge: Model
{
    public let type: VideoBadgeType?
    public let pictures: Pictures?
}

extension VideoBadge
{
    public enum VideoBadgeType: String, Codable
    {
        case staffPick = "staffpick"
        case staffPickPremiere = "staffpick-premiere"
        case staffPickBestOfTheMonth = "staffpick-best-of-the-month"
    }
}
