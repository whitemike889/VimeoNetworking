//
//  TeamMemberConnection.swift
//  VimeoNetworking
//
//  Created by Song, Alexander on 6/17/19.
//

import Foundation

@objc public class TeamMemberConnection: VIMConnection
{
    // MARK: - Properties
    
    @objc dynamic private var invites_remaining: NSNumber?
    
    // Number of invites remaining for a team
    @objc dynamic public var invitesRemaining: NSNumber?
    {
        set(value)
        {
            invites_remaining = value
        }
        get
        {
            return invites_remaining
        }
    }
}
