//
//  TeamMember.swift
//  VimeoNetworking
//
//  Created by Song, Alexander on 6/10/19.
//

import Foundation

public class TeamMember: VIMModelObject, ConnectionsProviding, ConnectionsParsing
{
    /// The created time for the project
    public private(set) var createdTime: NSDate?
    
    /// The member's email
    public private(set) var email: String?
    
    /// Determines whether the member has access to folder
    public private(set) var hasFolderAccess: Bool?
    
    /// URL user must open to join team
    public private(set) var inviteUrl: String?
    
    /// Time at which the invitee was accepted as member on team
    public private(set) var joinedTime: NSDate?
    
    /// The metadata containing associated connections
    internal var metadata: Metadata?
    
    /// The time at which membershipwas last modified
    public private(set) var modifiedTime: NSDate?
    
    /// The member's permission level
    public private(set) var permissionLevel: String?
    
    /// The team membership resource key
    public private(set) var resourceKey: String?
    
    /// The member's role
    public private(set) var role: String?
    
    /// The status of the member's status
    public private(set) var status: String?
    
    /// The unique identifier you use to access the team membership resource
    public private(set) var uri: String?
    
    /// The team member
    public private(set) var user: VIMUser?
    
    // MARK: - ConnectionsProviding
    
    public internal(set) var connections: [TeamMember.ConnectionKeys : VIMConnection] = [:]
    
    // MARK: - VIMModelObject overrides
    
    public override func didFinishMapping()
    {
        if let metadata = metadata
        {
            connections = parse(metadata)
        }
    }
    
    public override func getObjectMapping() -> Any?
    {
        return Mappings.membersByEncodingKeys
    }
    
    public override func getClassForObjectKey(_ key: String!) -> AnyClass?
    {
        return Mappings.classesByEncodingKeys[key]
    }
}

extension TeamMember
{
    struct Mappings
    {
        static let membersByEncodingKeys = [
            "created_time": "createdTime",
            "has_folder_access": "hasFolderAccess",
            "invite_url": "inviteUrl",
            "joined_time": "joinedTime",
            "modified_time": "modifiedTime",
            "permission_level": "permissionLevel",
            "resource_key": "resourceKey"
        ]
        
        static let classesByEncodingKeys = [
            "user": VIMUser.self
        ]
    }
}

// MARK: - ConnectionsParsing

extension TeamMember
{
    public enum ConnectionKeys: String, MetadataKeys
    {
        case owner
    }
    
    var connectionMapping: [TeamMember.ConnectionKeys: VIMConnection.Type]
    {
        return [.owner: TeamMemberConnection.self]
    }
}

// MARK: - Nested Types

extension TeamMember
{
    public enum PermissionLevel: String
    {
        case admin = "Admin"
        case contributor = "Contributor"
        case owner = "Owner"
        case uploader = "Uploader"
    }
    
    public enum Role: String
    {
        case admin = "Admin"
        case contributor = "Contributor"
        case owner = "Owner"
        case uploader = "Uploader"
    }
    
    public enum Status: String
    {
        case accepted
        case pending
    }
}
