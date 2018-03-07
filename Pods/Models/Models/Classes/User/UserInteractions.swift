//
//  Interactions.swift
//  Videos
//
//  Created by King, Gavin on 2/5/18.
//  Copyright © 2018 Vimeo. All rights reserved.
//

import Foundation

public struct UserInteractions: Model
{
    public let follow: MembershipInteraction?
    public let block: MembershipInteraction?
    public let report: UserReportInteraction?
}
